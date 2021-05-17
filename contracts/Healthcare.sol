// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

contract Healthcare{
    
    struct Patient{
        uint256 aadhaar;
        string name;
        string dob;
        string gender;
        string bloodGroup;
        uint256 emergencyContact;
        string [] prescriptions;
        address [] visitedDoctors;
        bool exist;
    }
    
    mapping(address => Patient) public PatientList;
    address public admin;
    
    constructor(){
        admin = msg.sender;
    }
    
    function addPatient(address patientAddr, uint256 _aadhaar, string memory _name,  string memory _dob,  string memory _gender, 
    string memory _bloodGroup, uint256 _emergencyContact)  external{
        require(msg.sender==admin, 'Only admin');
        require(PatientList[patientAddr].exist==false, 'already exists');
        PatientList[patientAddr].aadhaar = _aadhaar;
        PatientList[patientAddr].name = _name;
        PatientList[patientAddr].dob = _dob;
        PatientList[patientAddr].gender = _gender;
        PatientList[patientAddr].bloodGroup = _bloodGroup;
        PatientList[patientAddr].emergencyContact = _emergencyContact;
        PatientList[patientAddr].exist = true;
    }
    
    function modifyPatient( string memory _name) external{
        require(PatientList[msg.sender].exist==true, 'patient not  exists');
        PatientList[msg.sender].name = _name;
    }
    
    function getPatDetails(address patientAddr) public view returns(uint _aadhaar, string memory _name, string memory _dob,
    string memory _gender, string memory _bloodGroup, uint256 _emergencyContact, string memory _prescription){
         require(msg.sender==admin, 'Only admin');
        _aadhaar = PatientList[patientAddr].aadhaar;
        _name = PatientList[patientAddr].name; 
        _dob = PatientList[patientAddr].dob; 
        _gender = PatientList[patientAddr].gender; 
        _bloodGroup = PatientList[patientAddr].bloodGroup; 
        _emergencyContact = PatientList[patientAddr].emergencyContact; 
        _prescription = PatientList[patientAddr].prescriptions[0]; 
   }
    
    
    struct Doctor{
        string RegNo;
        string medCouncilName;
        string name;
        string areaExpertize;
        uint256 contactNo;
        bool exist;
    }
    
     mapping(address => Doctor) public DoctorList;
    
    function addDoctor(address docAddr, string memory _RegNo, string memory _medCouncilName,  string memory _name,  string memory _areaExpertize, uint256 _contactNo) external{
        require(msg.sender==admin, 'Only admin');
        require(DoctorList[docAddr].exist==false, 'already exists');
        DoctorList[docAddr] = Doctor(_RegNo,_medCouncilName,_name,_areaExpertize,_contactNo,true);
    }
    
    function getDocDetails(address docAddr) public view returns(string memory _RegNo, string memory _name){
         require(msg.sender==admin, 'Only admin');
        _RegNo = DoctorList[docAddr].RegNo;
        _name = DoctorList[docAddr].name; 
   }
    
    
    function addprescription(address _patientAddr,address _docAddr, string memory _prescription) public {
        require(DoctorList[msg.sender].exist==true && msg.sender == _docAddr, 'doctor not exists');
    
        PatientList[_patientAddr].prescriptions.push(_prescription);
        PatientList[_patientAddr].visitedDoctors.push(_docAddr);
    }
}
