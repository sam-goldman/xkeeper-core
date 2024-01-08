Follow these instructions to deploy with Sphinx on Sepolia. It should take you 5-10 minutes to finish.

Before we begin, a few notes:
* We'll deploy on Sepolia because Goerli is being deprecated.
* We've slightly modified the `DeployNativeETH.s.sol` script to be compatible with Sphinx. Particularly, we removed the logic that broadcasts the deployment from a private key.

1. Clone this fork of your repo:
```
git clone git@github.com:sam-goldman/xkeeper-core.git
```

2. 
```
cd xkeeper-core
```

3. Update Foundry, then install packages:
```
yarn install && yarn sphinx install
```

4. Sign in to the [Sphinx UI](https://sphinx.dev). Then, go to "Options" -> "API Credentials".
   You'll need these credentials in the next couple of steps.

5. Open `solidity/script/DeployNativeETH.s.sol`. The `setUp` function in `DeployNativeETH`
   contains your config options. Update the following fields:\
    a. In `sphinxConfig.orgId`, add the Organization ID from Sphinx's website. This is a public
    field, so you don't need to keep it secret.\
    b. In `sphinxConfig.owners`, add the addresses of the account(s) that will own your project.
    (Specifically, they'll own the Gnosis Safe that executes your deployment).

6. Create a `.env` file. Then, copy and paste the variables from `.env.example` to `.env` and fill
   them in. The `SPHINX_API_KEY` is in the Sphinx UI (under "Options" -> "API Credentials").

7. You're done with the configuration steps! Run `yarn test` to make sure your tests are passing.

8. Next, propose your deployment on Sepolia:
```
yarn propose:sepolia
```

9. When the proposal is finished, go to the [Sphinx UI](https://sphinx.dev) to approve the
   deployment. After you approve it, you can monitor the deployment's status in the UI while it's
   executed.
