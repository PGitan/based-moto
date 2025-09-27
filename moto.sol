/**
 *Submitted for verification at basescan.org on 2025-01-19
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JuiceMoto {
    // État de la moto
    uint public orangeCount;
    uint public fuelAmount;
    bool public isJuiceModeActive;

    // Événements pour signaler les actions
    event OrangesLoaded(uint amount);
    event FuelAdded(uint amount);
    event JuiceModeInstalled();
    event OrangesExploded(uint amount);

    // Constructeur pour initialiser les valeurs par défaut
    constructor() {
        orangeCount = 0;
        fuelAmount = 0;
        isJuiceModeActive = false;
    }

    // Fonction pour charger la moto avec un nombre aléatoire d'oranges
    function loadOranges() public {
        uint randomOranges = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % 100 + 1; // Entre 1 et 100 oranges
        orangeCount += randomOranges;
        emit OrangesLoaded(randomOranges);
    }

    // Fonction pour ajouter une quantité aléatoire d'essence
    function addFuel() public {
        uint randomFuel = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % 50 + 1; // Essence entre 1 et 50
        fuelAmount += randomFuel;
        emit FuelAdded(randomFuel);
    }

    // Fonction pour installer le mode "Juice"
    function installJuiceMode() public {
        isJuiceModeActive = true;
        emit JuiceModeInstalled();
    }

    // Fonction pour faire exploser un nombre aléatoire d'oranges
    function explodeOranges() public {
        require(orangeCount > 0, "Pas assez d'oranges pour les faire exploser.");
        uint randomExploded = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % orangeCount + 1; // Entre 1 et orangeCount
        orangeCount -= randomExploded;
        emit OrangesExploded(randomExploded);
    }

    // Fonction pour obtenir l'état actuel de la moto
    function getMotoStatus() public view returns (string memory) {
        string memory juiceStatus = isJuiceModeActive ? "actif" : "inactif";

        return string(abi.encodePacked(
            "Nombre d'oranges: ", uintToString(orangeCount),
            ", Quantite d'essence: ", uintToString(fuelAmount),
            ", Mode Juice: ", juiceStatus, "."
        ));
    }

    // Fonction utilitaire pour convertir un uint en string
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint maxLen = 100;
        bytes memory reversed = new bytes(maxLen);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        return string(s);
    }
}
