// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IndoCryptToken is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 2000000000 * 10 ** 18;

    constructor(uint256 initialSupply) ERC20("Indo Crypt Token", "ICT") Ownable(msg.sender) {
        require(initialSupply <= MAX_SUPPLY, "Initial supply cannot exceed max supply");
        _mint(msg.sender, initialSupply);
    }

    modifier checkMaxSupply(uint256 amount) {
        require(amount <= MAX_SUPPLY - totalSupply(), "Total supply cannot exceed max supply");
        _;
    }

    function mint(address to, uint256 amount) public onlyOwner checkMaxSupply(amount) {
        _mint(to, amount);
    }

    function transferProPlayerRewards(address receiver) public onlyOwner {
        _mint(receiver, 30000 * 10 ** 18);
    }

    function transferBountyRewards(address receiver) public onlyOwner {
        _mint(receiver, 30000 * 10 ** 18);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function lock(address to, uint256 amount) public {
        _transfer(msg.sender, to, amount);
    }

    function unlock(address from, uint256 amount) public onlyOwner {
        _transfer(from, msg.sender, amount);
    }
}
