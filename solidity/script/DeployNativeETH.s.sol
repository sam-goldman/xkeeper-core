// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Script} from 'forge-std/Script.sol';
import {Sphinx, Network} from '@sphinx-labs/contracts/SphinxPlugin.sol';

import {AutomationVaultFactory, IAutomationVaultFactory} from '@contracts/AutomationVaultFactory.sol';
import {AutomationVault, IAutomationVault} from '@contracts/AutomationVault.sol';
import {OpenRelay, IOpenRelay} from '@contracts/OpenRelay.sol';
import {GelatoRelay, IGelatoRelay} from '@contracts/GelatoRelay.sol';
import {Keep3rRelay, IKeep3rRelay} from '@contracts/Keep3rRelay.sol';
import {Keep3rBondedRelay, IKeep3rBondedRelay} from '@contracts/Keep3rBondedRelay.sol';
import {XKeeperMetadata, IXKeeperMetadata} from '@contracts/XKeeperMetadata.sol';
import {_ETH} from '@utils/Constants.sol';

abstract contract DeployNativeETH is Script, Sphinx {
  // AutomationVault contracts
  IAutomationVaultFactory public automationVaultFactory;
  IAutomationVault public automationVault;

  // Relay contracts
  IOpenRelay public openRelay;
  IGelatoRelay public gelatoRelay;
  IKeep3rRelay public keep3rRelay;
  IKeep3rBondedRelay public keep3rBondedRelay;

  // Metadata
  IXKeeperMetadata public xKeeperMetadata;

  // AutomationVault params
  address public owner;

  function setUp() public virtual {
    sphinxConfig.owners = [address(0)]; // Add owner address(es)
    sphinxConfig.orgId = ''; // Add org ID
    sphinxConfig.mainnets = [Network.ethereum];
    sphinxConfig.testnets = [Network.sepolia];
    sphinxConfig.projectName = 'Keep3r_Framework';
    sphinxConfig.threshold = 1;
  }

  function run() public sphinx {
    automationVaultFactory = new AutomationVaultFactory();
    automationVault = automationVaultFactory.deployAutomationVault(owner, _ETH, 0);

    openRelay = new OpenRelay();
    gelatoRelay = new GelatoRelay();
    keep3rRelay = new Keep3rRelay();
    keep3rBondedRelay = new Keep3rBondedRelay();

    xKeeperMetadata = new XKeeperMetadata();
  }
}

contract DeployMainnet is DeployNativeETH {
  function setUp() public override {
    DeployNativeETH.setUp();

    // AutomationVault setup
    owner = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
  }
}

contract DeploySepolia is DeployNativeETH {
  function setUp() public override {
    DeployNativeETH.setUp();

    // AutomationVault setup
    owner = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
  }
}
