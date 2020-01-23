pragma solidity ^0.5.11;

import "./erc20.sol" as token;

contract Courses {
    struct EtablissementEnseignementSuperieur {
        uint256 IdEES;
        string NomEtablissement;
        string Pays;
        string Type;
        string Adresse;
        string Site_Web;
        uint256 IdAgent;
    }

    struct Etudiant {
        uint256 IdEtudiant;
        string Nom;
        string Prenom;
        string DateNaissance;
        string Sexe;
        string Nationalite;
        string StatusCivil;
        string Adresse;
        string Courriel;
        string Telephone;
        string Session;
        string SujetPFE;
        string NomPrenom_MaitreDeStage;
        string DateDebutStage;
        string DateFinStage;
        string Evaluation;
    }

    struct Diplome {
        uint256 IdDiplome;
        uint256 IdEtudiant;
        string NomEtablissementEnseignementSuperieur;
        uint256 IdEES;
        string TypeDiplome;
        string Specialite;
        string Mension;
        string Date;
    }

    struct Entreprise {
        uint256 IdEntreprise;
        string NomEntreprise;
        string Secteur;
        string DateCreation;
        string ClassificationTaille;
        string Pays;
        string Adresse;
        string Courriel;
        string SiteWeb;
    }

    mapping(uint256 => EtablissementEnseignementSuperieur) tab_EES;
    mapping(uint256 => Etudiant) tab_Etudiant;
    mapping(uint256 => Diplome) tab_Diplome;
    mapping(uint256 => Entreprise) tab_Entrepise;

    // Tâche 1 - DONE
    function creerUnCompteEtablissementSuperieur(
        uint256 _IdEES,
        string memory _NomEtablissement,
        string memory _Pays,
        string memory _Type,
        string memory _Adresse,
        string memory _Site_Web,
        uint256 _IdAgent
    ) public {
        // We are using the EES ID for the map index.
        tab_EES[_IdEES].IdEES = _IdEES;
        tab_EES[_IdEES].NomEtablissement = _NomEtablissement;
        tab_EES[_IdEES].Pays = _Pays;
        tab_EES[_IdEES].Type = _Type;
        tab_EES[_IdEES].Adresse = _Adresse;
        tab_EES[_IdEES].Site_Web = _Site_Web;
        tab_EES[_IdEES].IdAgent = _IdAgent;
    }

    // Tâche 2 - DONE
    function creerProfilEtudiant(
        uint256 _IdEtudiant,
        string memory _Nom,
        string memory _Prenom,
        string memory _DateNaissance,
        string memory _Sexe,
        string memory _Nationalite,
        string memory _StatusCivil,
        string memory _Adresse,
        string memory _Courriel,
        string memory _Telephone,
        string memory _Session,
        string memory _SujetPFE,
        string memory _NomPrenom_MaitreDeStage,
        string memory _DateDebutStage,
        string memory _DateFinStage
    ) public {
        // We are using the Student ID for the map index.
        tab_Etudiant[_IdEtudiant].IdEtudiant = _IdEtudiant;
        tab_Etudiant[_IdEtudiant].Nom = _Nom;
        tab_Etudiant[_IdEtudiant].Prenom = _Prenom;
        tab_Etudiant[_IdEtudiant].DateNaissance = _DateNaissance;
        tab_Etudiant[_IdEtudiant].Sexe = _Sexe;
        tab_Etudiant[_IdEtudiant].Nationalite = _Nationalite;
        tab_Etudiant[_IdEtudiant].StatusCivil = _StatusCivil;
        tab_Etudiant[_IdEtudiant].Adresse = _Adresse;
        tab_Etudiant[_IdEtudiant].Courriel = _Courriel;
        tab_Etudiant[_IdEtudiant].Telephone = _Telephone;
        tab_Etudiant[_IdEtudiant].Session = _Session;
        tab_Etudiant[_IdEtudiant].SujetPFE = _SujetPFE;
        tab_Etudiant[_IdEtudiant]
            .NomPrenom_MaitreDeStage = _NomPrenom_MaitreDeStage;
        tab_Etudiant[_IdEtudiant].DateDebutStage = _DateDebutStage;
        tab_Etudiant[_IdEtudiant].DateFinStage = _DateFinStage;
        // Le champ Évaluation sera remplie à la fin du stage
        //tab_Etudiant[_IdEtudiant].Evaluation = _Evaluation;
    }

    // Tâche 3 - Almost DONE (mettre à jour les informations de son titulaire ??)
    function ajouterDiplome(
        uint256 _IdDiplome,
        uint256 _IdEtudiant,
        string memory _NomEtablissementEnseignementSuperieur,
        uint256 _IdEES,
        string memory _TypeDiplome,
        string memory _Specialite,
        string memory _Mention,
        string memory _Date
    ) public {
        // We are using the sum of the degree Id and the student ID to have a unique id
        // cause student can have the same degree.
        tab_Diplome[_IdDiplome + _IdEtudiant].IdDiplome = _IdDiplome;
        tab_Diplome[_IdDiplome + _IdEtudiant].IdEtudiant = _IdEtudiant;
        tab_Diplome[_IdDiplome + _IdEtudiant]
            .NomEtablissementEnseignementSuperieur = _NomEtablissementEnseignementSuperieur;
        tab_Diplome[_IdDiplome + _IdEtudiant].IdEES = _IdEES;
        tab_Diplome[_IdDiplome + _IdEtudiant].TypeDiplome = _TypeDiplome;
        tab_Diplome[_IdDiplome + _IdEtudiant].Specialite = _Specialite;
        tab_Diplome[_IdDiplome + _IdEtudiant].Mension = _Mention;
        tab_Diplome[_IdDiplome + _IdEtudiant].Date = _Date;
    }

    // Tâche 4 - DONE
    function creerCompteEntreprise(
        uint256 _IdEntreprise,
        string memory _NomEntreprise,
        string memory _Secteur,
        string memory _DateCreation,
        string memory _ClassificationTaille,
        string memory _Pays,
        string memory _Adresse,
        string memory _Courriel,
        string memory _SiteWeb
    ) public {
        // We are using the Enterprise ID for the map index.
        tab_Entrepise[_IdEntreprise].IdEntreprise = _IdEntreprise;
        tab_Entrepise[_IdEntreprise].NomEntreprise = _NomEntreprise;
        tab_Entrepise[_IdEntreprise].Secteur = _Secteur;
        tab_Entrepise[_IdEntreprise].DateCreation = _DateCreation;
        tab_Entrepise[_IdEntreprise]
            .ClassificationTaille = _ClassificationTaille;
        tab_Entrepise[_IdEntreprise].Pays = _Pays;
        tab_Entrepise[_IdEntreprise].Adresse = _Adresse;
        tab_Entrepise[_IdEntreprise].Courriel = _Courriel;
        tab_Entrepise[_IdEntreprise].SiteWeb = _SiteWeb;
    }

    // 5. WIP - AJOUTER LA PARTIE TOKEN
    function evaluerEtudiantFinDeStage(
        uint256 _IdEtudiant,
        string memory _Evaluation
    ) public {
        tab_Etudiant[_IdEtudiant].Evaluation = _Evaluation;
    }

    // 6. TODO
    function getToken() public {}

    // 7. WIP - AJOUTER LA PARTIE TOKEN
    function verifierDiplomeCandidat(uint256 _IdEtudiant, uint256 _IdDiplome)
        public
        returns (bool)
    {
        if (tab_Diplome[_IdEtudiant + _IdDiplome].IdDiplome == _IdDiplome)
            return true;
        else return false;
    }

    ///////// TODO ////////////
    // 1. DONE
    // Un agent d’un établissement d’enseignement supérieur peut créer un compte pour son établissement
    // qui va servir à enregistrer les jeunes diplômés et leurs diplômes.
    //
    // 2. DONE
    // Un agent d’un établissement d’enseignement supérieur peut créer et sauvegarder un profil
    // pour un étudiant lorsque ce dernier commence son stage de fin d’étude.
    //
    // 3. Almost DONE (mettre à jour les informations de son titulaire ??)
    // Un agent d’un établissement d’enseignement supérieur peut ajouter un diplôme et mettre à jour les informations de son titulaire.
    //
    // 4. DONE
    // Un agent de recrutement peut créer un compte pour son entreprise.
    //
    // 5. WIP - AJOUTER LA PARTIE TOKEN
    // Un agent de recrutement peut évaluer un étudiant en stage de fin d’étude et sera
    // rémunéré en tokens.
    //
    // 6. TODO
    // Un agent de recrutement peut acquérir des tokens pour le compte de son entreprise
    // et qui vont servir au paiement des frais de la vérification de l’authenticité des
    // diplômes.
    //
    // 7. WIP - AJOUTER LA PARTIE TOKEN
    // Un agent de recrutement peut vérifier l’authenticité d’un diplôme d’un candidat et
    // paie les frais en tokens.

}
