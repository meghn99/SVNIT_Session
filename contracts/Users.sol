// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.14;

contract Users {
    struct User {
        address walletAddress;
        string id;
        string name;
        string email;
        string password;
    }

    address[] UserArr;

    mapping(address => User) public users;

    function createUser(
        address _walletAddress,
        string memory _userid,
        string memory _name,
        string memory _email,
        string memory _password
    ) public {
        users[msg.sender] = User({
            walletAddress: _walletAddress,
            id: _userid,
            name: _name,
            email: _email,
            password: _password
        });
        UserArr.push(_walletAddress);
    }

    function getData() public view returns (address[] memory) {
        return UserArr;
    }
}
