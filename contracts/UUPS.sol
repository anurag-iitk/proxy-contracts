// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract MyContractProxy is ERC1967Proxy {
    constructor(address _logic, bytes memory _data) ERC1967Proxy(_logic, _data) {}
}

contract MyContractV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 public value;

    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
        value = 0;
    }

    function setValue(uint256 newValue) public onlyOwner {
        value = newValue;
    }

    function getValue() public view returns (uint256) {
        return value;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function upgrade(address newImplementation) public onlyOwner {
        upgradeToAndCall(newImplementation, "");
    }
}

contract MyContractV2 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 public value;

    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
        value = 0;
    }

    function setValue(uint256 newValue) public onlyOwner {
        value = newValue;
    }

    function getValue() public pure returns (uint256) {
        return 123;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function upgrade(address newImplementation) public onlyOwner {
        upgradeToAndCall(newImplementation, "");
    }
}