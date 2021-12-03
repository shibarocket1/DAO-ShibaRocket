// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract DAOShibaRocketVoting is Initializable, ERC20Upgradeable, OwnableUpgradeable, ERC20PermitUpgradeable, ERC20VotesUpgradeable {
    
    mapping(address => bool) public owners;

    modifier onlyOwners{
        require(owners[msg.sender],'Not an owner address');
        _;
    }

    function initialize(address _stakingContract) initializer public {
        __ERC20_init("DAO ShibaRocket Voting", "DSV");
        __Ownable_init();
        __ERC20Permit_init("DAO ShibaRocket Voting");
        owners[msg.sender] = true;
        owners[_stakingContract] = true;


        //_mint(msg.sender, 5000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) external onlyOwners returns (bool){
        _mint(to, amount);
        return true;
    }

    function burn(uint256 amount) external onlyOwners returns (bool){
        require(balanceOf(msg.sender) >= amount,'Insufficient Tokens');
        _burn(msg.sender, amount);
        return true;
    }

    // The following functions are overrides required by Solidity.

    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20Upgradeable, ERC20VotesUpgradeable)
    {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20Upgradeable, ERC20VotesUpgradeable)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20Upgradeable, ERC20VotesUpgradeable)
    {
        super._burn(account, amount);
    }
}
