pragma solidity 0.5.11;

/**
* @title ERC20Basic
* @dev Simpler version of ERC20 interface
* @dev see https://github.com/ethereum/EIPs/issues/179
*/

contract ERC20Basic {
function totalSupply() public view returns (uint256);
function balanceOf(address who) public view returns (uint256);
function transfer(address to, uint256 value) public returns (bool);
event Transfer(address indexed from, address indexed to, uint256 value);
}

/**
* @title ERC20 interface
* @dev see https://github.com/ethereum/EIPs/issues/20
*/

contract ERC20 is ERC20Basic {
function allowance(address owner, address spender) public view returns (uint256);
function transferFrom(address from, address to, uint256 value) public returns (bool);
function approve(address spender, uint256 value) public returns (bool);
function transfers(address from_,address _to, uint256 _value) public returns (bool);
event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Diploma {

// Structure établissement d'enseignement supérieur
struct Etablissement {
uint id_Etab;
string nomEtab;
string typeEtab;
string paysEtab;
string siteEtab;
uint id_AgentEtab;
}

// Mapping des établissements = tableau des établissements
mapping (uint => Etablissement) Etablissemnts;
uint[] idEtablissements;

// Structure étudiant
struct Etudiant {
uint id_E;
string nomE;
string prenomE;
uint date_NaissanceE;
string sexeE;
string nationaliteE;
string status_CivE;
string adresseE;
string courrielE;
uint256 telephoneE;
string sectionE;
uint id_Etab;
uint id_D;
uint id_Ent;
string sujet_PfeE;
string nom_Prenom_MaitreE;
uint date_DebutE;
uint date_FinE;
uint evaluationE;
}

// Mapping des étudiants = tableau des étudiants
mapping(uint=> Etudiant) Etudiants;
uint[] idEtudiants;


// Structure diplôme
struct Diplome {
uint id_D;
uint id_TitulaireD;
string nom_EtablissementD;
uint id_EtablissementD;
string paysD;
string typeD;
string specialitD;
string mentionD;
uint date_ObtentionD;
}

// Mapping des diplômes = tableau des diplômes
mapping(uint => Diplome) Diplomes;
uint[] idDiplomes;

// Structure entreprise
struct Entreprise {
uint id_Ent;
string nomEnt;
string secteurEnt;
uint date_CreationEnt;
string classification_TailleEnt;
string paysEnt;
string adresseEnt;
string courrielEnt;
string sitewebEnt;
uint256 telephoneEnt;
}

// Mapping des entreprises = tableau des entreprises créées
mapping (uint=> Entreprise) Entreprises;
uint[] idEntreprises;






/************************ GESTION DES TOKENS ***********************/

// Mapping des tokens = tableau des tokens utilisés par notre application ---> dans notre cas, on garde l'hypothése d'utiliser un seul token
mapping(bytes32 => address) public tokens;

ERC20 public ERC20Interface;

// Fonction qui permet d'ajouter un nouveau token à l'app diplôme
function addNewToken(address address_) public returns (bool) {
bytes32 symbol_ = convertttt();
tokens[symbol_] = address_;
return true;
}

// Fonction qui permet de convertir le symbole du token de string vers du bytes32
function convertttt() public pure returns (bytes32 result) {
string memory testFoo = "AUT";
assembly {
result := mload(add(testFoo, 32))
}
}

// Fonction qui permet au smart contract diplome de transferer des tokens
function transaction(address Address_Sender , address Address_Receiver , uint Montant) public {
bytes32 symbol_ = convertttt();
address contract_ = tokens[symbol_];
ERC20Interface = ERC20(contract_);
ERC20Interface.transfers(Address_Sender, Address_Receiver , Montant);
}

// how many token units a buyer gets per wei
uint256 public rate = 100;


// low level token purchase function
// le mot payable est requis pour autoriser la fonction à recevoir de l'ETHER. Toute fonction nécessitant des frais en ETHER pour son execution doit compoorter ce mot clé
function buyTokens(address beneficiary) public payable {
require(beneficiary != address(0));

uint256 weiAmount = msg.value;

// calculate token amount to be created
uint256 tokenamount = weiAmount * rate;

bytes32 symbol_ = convertttt();
address contract_ = tokens[symbol_];
ERC20Interface = ERC20(contract_);

// on indique l'adresse du owner des tokens qu'on a déployé
// la valeur en ETHER est conservée au sein du smart contract de diplome
ERC20Interface.transfers(0xa708791Da6A59fb0D3F416D3b1eb5972984A9872, beneficiary , tokenamount);

//emit TokenPurchase(msg.sender, beneficiary, weiAmount, tokenamount);

}

/************************ GESTION DES TOKENS ***********************/







// Fonction qui permet d'ajouter un nouvel établissement

function addEtab( uint id_Etab,
string memory nomEtab,
string memory paysEtab,
string memory siteEtab,
uint id_AgentEtab
) public
{
require(Etablissemnts[id_Etab].id_Etab == 0);

Etablissemnts[id_Etab].id_Etab = id_Etab;
Etablissemnts[id_Etab].nomEtab = nomEtab;
Etablissemnts[id_Etab].paysEtab = paysEtab;
Etablissemnts[id_Etab].siteEtab =siteEtab;
Etablissemnts[id_Etab].id_AgentEtab =id_AgentEtab;
idEtablissements.push(id_Etab);
}


// Fonction permet de verifier l'authenticité d'un diplôme

function verif (uint id_D,uint id_TitulaireD, string memory nom_EtablissementD) public returns(bool){
uint i = 0;
bool verifer = false;

// Le paiement des frais de vérification d'authenticité = 10 tokens par opération

transaction(msg.sender ,address(this) ,10);
while( i<idDiplomes.length && (verifer == false)){
if(id_D == Diplomes[id_D].id_D){
if((id_TitulaireD == Diplomes[id_D].id_TitulaireD) && (keccak256(abi.encodePacked(nom_EtablissementD)) == keccak256(abi.encodePacked(Diplomes[id_D].nom_EtablissementD))))
{
verifer = true;
}

}
i++;
}
return(verifer);
}


// Fonction qui permet d'ajouter un nouveau étudiant

function addE( uint id_E, string memory nomE, string memory prenomE, uint date_NaissanceE, string memory sexeE, string memory nationaliteE,
string memory status_CivE, string memory adresseE, string memory courrielE, uint256 telephoneE, string memory sectionE, uint id_Etab, uint id_D) public
{
require(Etudiants[id_E].id_E == 0);
Etudiants[id_E].id_E = id_E;
Etudiants[id_E].nomE = nomE;
Etudiants[id_E].prenomE = prenomE;
Etudiants[id_E].date_NaissanceE =date_NaissanceE;
Etudiants[id_E].nationaliteE =nationaliteE;
Etudiants[id_E].sexeE = sexeE;
Etudiants[id_E].status_CivE = status_CivE;
Etudiants[id_E].adresseE = adresseE;
Etudiants[id_E].courrielE =courrielE;
Etudiants[id_E].telephoneE =telephoneE;
Etudiants[id_E].sectionE = sectionE;
Etudiants[id_E].id_Etab =id_Etab;
Etudiants[id_E].id_D =id_D;
idEtudiants.push(id_E);
}

// Fonction qui permet d'affecter un stage de fin d'étude à un étudiant

function affectEtudiant (uint id_E , uint id_Ent,string memory sujet_PfeE, string memory nom_Prenom_MaitreE, uint date_DebutE, uint date_FinE) public {
require(Etudiants[id_E].id_E != 0);
Etudiants[id_E].id_Ent =id_Ent;
Etudiants[id_E].sujet_PfeE =sujet_PfeE;
Etudiants[id_E].nom_Prenom_MaitreE = nom_Prenom_MaitreE;
Etudiants[id_E].date_DebutE = date_DebutE;
Etudiants[id_E].date_FinE = date_FinE;
Etudiants[id_E].evaluationE = 0;
}

// Fonction qui permet d'ajouter un diplôme et de l'associer à un étudiant

function addDiplome(uint id_D, uint id_TitulaireD,
string memory nom_EtablissementD,
uint id_EtablissementD,
string memory paysD,
string memory typeD,
string memory specialitD,
string memory mentionD,
uint date_ObtentionD
) public
{
require(Diplomes[id_D].id_D == 0);
Diplomes[id_D].id_D=id_D;
Diplomes[id_D].id_TitulaireD=id_TitulaireD;
Diplomes[id_D].nom_EtablissementD=nom_EtablissementD;
Diplomes[id_D].id_EtablissementD=id_EtablissementD;
Diplomes[id_D].paysD=paysD;
Diplomes[id_D].typeD=typeD;
Diplomes[id_D].specialitD=specialitD;
Diplomes[id_D].mentionD=mentionD;
Diplomes[id_D].date_ObtentionD=date_ObtentionD;
idDiplomes.push(id_D);
}

// Fonction qui permet d'ajouter une nouvelle entreprise

function addEntreprise(uint id_Ent,

string memory nomEnt,
string memory secteurEnt,
uint date_CreationEnt,
string memory classification_TailleEnt,
string memory paysEnt,
string memory adresseEnt,
string memory courrielEnt,
string memory sitewebEnt,
uint256 telephoneEnt
) public
{
require(Entreprises[id_Ent].id_Ent == 0);

Entreprises[id_Ent].id_Ent=id_Ent;

Entreprises[id_Ent].nomEnt=nomEnt;
Entreprises[id_Ent].secteurEnt=secteurEnt;
Entreprises[id_Ent].date_CreationEnt=date_CreationEnt;
Entreprises[id_Ent].classification_TailleEnt=classification_TailleEnt;
Entreprises[id_Ent].paysEnt=paysEnt;
Entreprises[id_Ent].adresseEnt=adresseEnt;
Entreprises[id_Ent].courrielEnt=courrielEnt;
Entreprises[id_Ent].sitewebEnt=sitewebEnt;
Entreprises[id_Ent].telephoneEnt=telephoneEnt;

}


// Fonction qui permet d'évaluer un étudiant durant son stage PFE
function evaluer(address owner, uint id_E, uint id_Ent, uint evaluationE)public {
require(Etudiants[id_E].id_Ent == id_Ent);
require(Etudiants[id_E].evaluationE == 0);
Etudiants[id_E].evaluationE = evaluationE;
// L'évaluation est rémunéré de 15 tokens
transaction(owner,msg.sender,15);

}

// Fonction qui permet de retourner les informations d'un étudiant
function getE(uint id_E)public view returns(uint, string memory, string memory, string memory,uint256, string memory, uint){
return (Etudiants[id_E].id_E, Etudiants[id_E].status_CivE,Etudiants[id_E].adresseE , Etudiants[id_E].courrielE ,Etudiants[id_E].telephoneE,
Etudiants[id_E].sectionE, Etudiants[id_E].evaluationE);
}

// Fonction qui permet de retourner les informations d'une entreprise
function getEnt(uint id_Ent) view public returns(

string memory ,
string memory ,
uint ,
string memory ,
string memory ,
string memory

){
return (

Entreprises[id_Ent].nomEnt,
Entreprises[id_Ent].secteurEnt,
Entreprises[id_Ent].date_CreationEnt,
Entreprises[id_Ent].classification_TailleEnt,
Entreprises[id_Ent].paysEnt,
Entreprises[id_Ent].adresseEnt

);
}


// Fonction qui permet de retourner les informations d'un établissement
function getEtab(uint id_Etab) view public returns(uint ,
string memory ,
string memory ,
string memory ,
uint ){
return (
Etablissemnts[id_Etab].id_Etab ,
Etablissemnts[id_Etab].nomEtab ,
Etablissemnts[id_Etab].paysEtab ,
Etablissemnts[id_Etab].siteEtab ,
Etablissemnts[id_Etab].id_AgentEtab );
}


// Fonction qui permet de retourner les informations d'un diplôme
function getDiplome (uint id_D) public view returns( uint ,
uint ,
string memory ,
uint ,
string memory ,
string memory ,
uint
)
{

return( Diplomes[id_D].id_D ,
Diplomes[id_D].id_TitulaireD,
Diplomes[id_D].nom_EtablissementD,
Diplomes[id_D].id_EtablissementD,
Diplomes[id_D].paysD,
Diplomes[id_D].specialitD,
Diplomes[id_D].date_ObtentionD);

}





}