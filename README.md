# hardhat 使用

## 入门

### 安装:
```
npm install --save-dev hardhat
```

### 创建项目:
```
npx hardhat
```

### 查看 hardhat 自建账户
```
npx hardhat accounts
```

### 编译合约:
```
npx hardhat compile
```

### 测试合约:
```
npx hardhat test
```

### 部署合约:
在`script`目录中，有js引用的部署入口
```
npx hardhat run scripts/sample-script.js
```

### 将钱包或者DApp 链接到 hardhat 
启动内置节点
```
npx hardhat node 
```

### 将合约部署到本地节点
```
npx hardhat run scripts/sample-script.js --network localhost
```

## [配置项](https://hardhat.org/config/)

要设置配置，您必须从中导出一个对象hardhat.config.js
eg:
```
module.exports = {
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {
    },
    rinkeby: {
      url: "https://eth-mainnet.alchemyapi.io/v2/123abc123abc123abc123abc123abcde",
      accounts: [privateKey1, privateKey2, ...]
    }
  },
  solidity: {
    version: "0.5.15",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
}
```
### 部署到 NewChain
编译完成之后，可以在 `artifacts/contracts/SampleERC721.sol/SampleERC721.json` 中获取 `abi` 和 `bin` 信息，
使用 [tokenCommander](https://github.com/newtonproject/tokencommander) 部署到 `newchain`

```
tokenCommander deploy --abi {abiPath} --bin {binPath} --name SampleERC721 TOKEN_NAME TOKEN_SYMBOL
```

### 与 NewChain 交互
```

```
