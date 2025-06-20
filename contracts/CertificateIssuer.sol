// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CertificateIssuer {
    address public admin;

    struct Certificate {
        string studentName;
        string courseName;
        uint256 issueDate;
        bool isValid;
    }

    mapping(address => Certificate[]) public certificates;

    event CertificateIssued(address indexed student, string courseName);
    event CertificateRevoked(address indexed student, uint256 index);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function issueCertificate(address _student, string memory _studentName, string memory _courseName) public onlyAdmin {
        Certificate memory cert = Certificate(_studentName, _courseName, block.timestamp, true);
        certificates[_student].push(cert);
        emit CertificateIssued(_student, _courseName);
    }

    function revokeCertificate(address _student, uint256 index) public onlyAdmin {
        require(index < certificates[_student].length, "Invalid certificate index.");
        certificates[_student][index].isValid = false;
        emit CertificateRevoked(_student, index);
    }

    function getCertificate(address _student, uint256 index) public view returns (Certificate memory) {
        require(index < certificates[_student].length, "Invalid certificate index.");
        return certificates[_student][index];
    }
}
