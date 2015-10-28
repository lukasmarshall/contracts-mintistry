/*Standard Mintistry Metacoin Implementation
Based on Ethereum tutorial material and API outlined at:
https://github.com/ethereum/wiki/wiki/Standardized_Contract_APIs
*/
contract customCoin { 
  mapping (address => uint) public balance;
  event Transfer(address indexed from, address indexed to, uint256 value);
  event AddressApproval(address indexed address, address indexed proxy, bool result);
  event AddressApprovalOnce(address indexed address, address indexed proxy, uint256 value);
  address public issuer;
  bytes32 public name;

  /* Initialize contract with initial supply tokens to the coin issuer */
  function customCoin(uint supply, address coin_issuer, bytes32 coin_name) {
    balance[coin_issuer] = supply;
    issuer = coin_issuer;
    name = coin_name;
  }

  /* Simple coin sending function */
  function transfer(address _to, uint256 _value) returns(bool success) {
    if (balance[msg.sender] < _value) return false;
    balance[msg.sender] -= _value;
    balance[_to] += _value;
    Transfer(msg.sender, _to, _value);
    return true;
  }

  /* Simple coin sending function again but with a from address. 
  For the moment we will not allow account authorisation so this will function the same as the transfer function above.*/
  function transferFrom(address _from, address _to, uint256 _value) returns(bool success) {
    if (msg.sender != _from) return false;
    if (balance[_from] < _value) return false;
    balance[_from] -= _value;
    balance[_to] += _value;
    Transfer(_from, _to, _value);
    return true;
  }

  /*Return the balance of a given address - can already be used with balance() but complying with API standard here.*/
  function balanceOf(address _address) constant returns (uint256 balance){
    return balance[_address];
  }

  /*The following functions are set to return false as in this implementation 
  we do not want to authorise direct debit accounts.*/
  function approve(address _address) returns (bool _success){
    return false;
  }

  function unapprove(address _address) returns (bool _success){
    return false;
  }

  function isApprovedFor(address _target, address _proxy) constant returns (bool _r){
    return false;
  }

  function approveOnce(address _address, uint256 _maxValue) returns (bool _success){
    return false;
  }

  function isApprovedOnceFor(address _target, address _proxy) returns (uint256 _maxValue){
    return 0;
  }


}