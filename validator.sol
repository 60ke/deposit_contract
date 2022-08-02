// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Validate{
  event Print(address[]);
  mapping(address =>bool) public currentValidatorSet;
  address[] public Validators;


  constructor(){
    Validators.push(0x0AF48384F2A5E6Af457FaEc584Dc5593d0Ad370e);
    currentValidatorSet[0x0AF48384F2A5E6Af457FaEc584Dc5593d0Ad370e]=true;
    Validators.push(0x29dA95fa6ed88b431218A54bd8dFEAD68918A3B5);
    currentValidatorSet[0x29dA95fa6ed88b431218A54bd8dFEAD68918A3B5]=true;          
    Validators.push(0x38580eFe497b22ACc29783273e725a2a4F2AEEA4);
    currentValidatorSet[0x38580eFe497b22ACc29783273e725a2a4F2AEEA4]=true;
    Validators.push(0x3b6E67C4c837db054AC719892f871264E1456cDf);
    currentValidatorSet[0x3b6E67C4c837db054AC719892f871264E1456cDf]=true;
    Validators.push(0x947DD1558257a631049Fad9D686f427F86033c16);
    currentValidatorSet[0x947DD1558257a631049Fad9D686f427F86033c16]=true;
              
  }



  function exist(address valAddr,address[] memory addrs) internal pure returns(bool){
      uint n = addrs.length;
      for (uint i; i<n; ++i){
          if (addrs[i] == valAddr){
              return true;
          }
      }
      return false;
  }
  function trustdeposit(address[] memory addrs,bool update) public{
      // 更新现有validators的状态
      if (!update){
        uint n = Validators.length;
        for (uint i; i<n; ++i){
          address valAddr = Validators[i];
          if (!exist(valAddr,addrs)){
          currentValidatorSet[valAddr]=false;
            }
        }
      }

      // 添加新的validators
      uint n1 = addrs.length;
      for (uint i; i<n1; ++i){
        address valAddr = addrs[i];
        if (!exist(valAddr,Validators)){
        Validators.push(valAddr);
        currentValidatorSet[valAddr]=true;
        }else{
          currentValidatorSet[valAddr]=true;
        }
      }      
  }


  function jail(address addr) public{
      currentValidatorSet[addr] = false;
  }

  function getValidators() public returns(address[] memory) {
    uint n = Validators.length;
    

    uint len = 0;
    for (uint i; i<n; ++i) {
      if (currentValidatorSet[Validators[i]]) {
        len ++;
      }
    }

    address[] memory consensusAddrs = new address[](len);
    uint valid = 0;
    for (uint i; i<n; ++i) {
      if (currentValidatorSet[Validators[i]]) {
        consensusAddrs[valid] = Validators[i];
        valid ++;
      }
    }

    emit Print(consensusAddrs);
    return consensusAddrs;
  }  
}
