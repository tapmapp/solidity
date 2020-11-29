// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Members {
    address owner;
    struct Member {
        bytes32 id;
        string name;
        uint256 createdAt;
        bool available;
    }
    mapping(bytes32 => Member) private members;
    bytes32[] private memberIds;
    
    modifier onlyOwner() {
      require(msg.sender == owner);
      _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function getMemberIds() public view returns(bytes32[] memory ids) {
        return memberIds;
    }
    
    function getMember(bytes32 _id) public view returns(string memory memberName) {
        require(members[_id].available, "The member doesn't exist!");
        return members[_id].name;
    }
    
    function addMember(string memory _name) public onlyOwner returns(bool success) {
        require(bytes(_name).length > 0, "The member's name cannot be empty!");
        
        bytes32 blockHash = blockhash(block.number - 1);
        bytes32 id = keccak256(abi.encodePacked(msg.sender, _name, block.timestamp, blockHash));
        
        members[id] = Member({
            id: id,
            name: _name,
            createdAt: block.timestamp,
            available: true
        });
        memberIds.push(id);
        
        return true;
    }
}