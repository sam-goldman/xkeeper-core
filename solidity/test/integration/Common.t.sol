// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';

import {BasicJob} from '@contracts/for-test/BasicJob.sol';
import {DeployNativeETH} from '@script/DeployNativeETH.s.sol';

contract DeployForTest is DeployNativeETH {
  uint256 private constant _FORK_BLOCK = 18_500_000;

  function setUp() public virtual override {
    DeployNativeETH.setUp();

    // Mainnet fork
    vm.createSelectFork('ethereum', _FORK_BLOCK);

    // AutomationVault setup
    owner = makeAddr('Owner');
  }
}

abstract contract CommonIntegrationTest is DeployForTest, Test {
  // Events
  event Worked();

  // ForTest contracts
  BasicJob public basicJob;

  // EOAs
  address public bot;

  function setUp() public virtual override {
    DeployForTest.setUp();

    bot = makeAddr('Bot');

    basicJob = new BasicJob();

    run();
  }
}
