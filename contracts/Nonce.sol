pragma solidity ^0.8.9;

struct Nonce {
    mapping(uint248 => uint256) flag;
}

library NonceLibrary {
    function parse(uint256 _nonce) internal pure returns(uint248 key, uint8 index){
        key = uint248(_nonce >> 8);
        index = uint8(_nonce ^ uint256(key) << 8);
    } 
    
    function use(Nonce storage nonce, uint256 _nonce) internal {
        (uint248 key, uint8 index) = parse(_nonce);
        nonce.flag[key] ^= 1 << index;
    }

    function used(Nonce storage nonce, uint256 _nonce) internal view returns(bool){
        (uint248 key, uint8 index) = parse(_nonce);
        uint256 mask = 1 << index;
        return (nonce.flag[key] & mask) == mask;
    }
}
