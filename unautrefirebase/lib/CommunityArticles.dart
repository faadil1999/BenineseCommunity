import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CommunityArticles extends StatefulWidget {
  const CommunityArticles({Key? key}) : super(key: key);

  @override
  _CommunityArticlesState createState() => _CommunityArticlesState();
}

class _CommunityArticlesState extends State<CommunityArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Les Articles"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            titre("1-IDENTITE -LOGO",Colors.red),

            articles(500, 180, 1,"Il est créé en Fédération de Russie, une association à but non lucratif, laïque non discriminatif dénommée : Association des Béninois en Russie- Section de Saint Petersbourg ci-après désignée AEBR-SPB. AEBR-SPB est une association fondée en 2010."),
            articles(500,300 , 2 ," Le logo officiel de l’AEBR-SPB est une association de couleurs, de symboles de lettres dans un schéma bien élaboré qui cadre avec la vision de l’association. Il est conforme au logo de l’association des Béninois en Russie (AEBR). Par ailleurs, l’insigne de AEBR-SPB est le logo sous les différentes formes de pin’s et autres gadgets produits uniquement ou sur ordre de AEBR-SPB."),
            titre("2-VISION ET OBJECTIF.",Colors.yellow),
            articles(500 , 180 , 3 ,"AEBR-SPB a pour but de créer et de maintenir un contact étroit entre les Béninois de l’étranger (Saint-Pétersbourg) et le Bénin et de défendre les intérêts moraux et matériels des Béninois résidants ou ayant résidé́ à Saint-Pétersbourg. Sa durée est illimitée."),
            articles (500 , 180 , 4 ,"Pour réaliser son but, l’Association travaille en liaison étroite avec tous les organismes publics ou privés dont l’activité́ bénéficie directement ou indirectement aux Béninois résidants à l’étranger (Saint-Pétersbourg). Elle publie la revue « La Voix du Bénin », ainsi que toutes publications concourant à la réalisation de son but."),
            titre("3-COMPOSITION",Colors.red),
            articles(500, 480 , 5 ,"L’Association se compose :\n — De personnes physiques de nationalité́ béninoise qui adhèrent à l’association. Ces personnes physiques sont :\n − Adhérents \n − Membres bienfaiteurs \n − Membres d’honneur agréés par le Bureau Exécutif : \n La qualité de membre d’honneur peut être décernée à tout membre actif ou sympathisant ayant fait preuve de fidélité, disponibilité et de générosité dans le seul but de contribuer au bien-être physique, mental et social à travers les activités de AEBR-SPB.\n  Le Profil recherché :\n #Personnes âgées d’au moins 21ans ; \n #Etre adhérent ou bienfaiteur depuis au moins 2ans.",),
            articles(500, 200 , 6 , "Les valeurs recherchées chez les membres sont :\n • L’esprit d’équipe ; \n• La solidarité ; \n • Le dynamisme ;\n • La probité ;\n • L’humilité."),
            articles(500,180,7,"Le montant annuel des cotisations dues à l’Association par les différentes catégories de membres est fixé par l’assemblée génerale avec possibilite demodification par le bureau. La somme de 100 roubles par mois a ete retenu."),
            titre("4-CARTE DE MEMBRE",Colors.yellow),
            articles(500,200,8,"\n          -CONDITIONS DE DELIVRANCE- \n La carte de membre conçue au siège est individuelle et personnelle et son retrait est effectué trois (3) mois après la date d’enregistrement, de participation aux activités et de cotisations régulières en tant que membre actif."),
            articles(500,300,9,"\n          -VALIDITE-RENOUVELLEMENT- \nLa carte de membre a une validité de deux (2) ans et renouvelables par tout membre en règles.\nLe renouvellement est subordonné au dépôt d’un nouveau dossier constitué de :\n • La demande de renouvellement adressée au Président de AEBR-SPB ; \n • L’ancienne carte de membre ;\n • Deux (02) photos d’identité ; \n • Les frais d’impression de la carte."),
            articles(500,350,10,"\n                  -SITUATION DE PERTE- \n En cas de perte de la carte, le membre concerné formule une déclaration de perte au bureau exécutif dans les 72 heures suivant la disposition de la carte. \n Le concerné prend entièrement en charge tous les frais de rétablissement en constituant un nouveau dossier constitué de :\n • Une demande de rétablissement de carte ;\n • Quatre photos d’identité ; \n• Frais d’impression de carte."),
            titre("5-ADMINISTRATION ET\n FONCTIONNEMENT",Colors.red),
            articles(500,350,11,"1-)L’Association est administrée par un bureau exécutif dont le nombre de membres, fixé par délibération de l’assemblée générale, est compris entre 4 membres au moins et 8 membres au plus. Les membres du conseil d’administration sont élus au scrutin secret pour 1ans par l’assemblée générale et renouvelables par tiers. Les membres sortants sont rééligibles. Les présidents et vice-présidents d’honneur peuvent assister au conseil d’administration avec voix consultative, sur invitation du président."),
            articles(500,300,11,"2-)\n- En cas de vacance, le conseil d’administration pourvoit provisoirement au remplacement de ses membres. Il est procédé à leur remplacement définitif par la plus prochaine assemblée générale.\n - De plus tout membre de lAsociation en derniere annee detude ne peux etre membre du Bureau. Le mandat des membres ainsi désignés prend fin à la date à laquelle expire le mandat des membres remplacés."),
            articles(500,300,11,"3-) L’assemblée générale choisit parmi ses membres, au scrutin secret, un bureau composé du président, du secrétaire général , du trésorier et de l’organisateur générale. L’effectif du bureau ne doit pas dépasser le tiers de celui de l’assemblée générale (AG). Le bureau est élu pour 1an. En cas de démission ou de vacance d’un poste du bureau, l’AG élit le nouveau titulaire, dont le mandat expire à la date à laquelle se termine le mandat du membre remplacé."),
            articles(500,300,12 ,"1) L’AG se réunit au moins une fois mensuellement. Il se réunit sur convocation du président ou sur demande du quart des membres de l’association. Chaque membre de l’Association, personne physique ou personne morale représentée, dispose d’une voix. Cette rencontre peut se faire en ligne selon les circonstances.\n 2) L’ordre du Jour de l’assemblée générale est réglé par le BE.\n 3) La présence de 2/3 des membres (présents ou représentés) lors des AG est nécessaire pour la validité des délibérations."),
            articles(500,250,12,"4) Il est tenu procès-verbal des séances. Les procès-verbaux sont signés par le président et le secrétaire général. Ils sont établis sans blancs, ni ratures, sur des feuillets numérotés et conservés.\n 5) Sauf application des dispositions de l’article précédent, les agents rétribués, non membres de l’Union, n’ont pas accès à l’assemblée générale."),
            articles(500,180,13,"Le président représente l’Association dans tous les actes de la vie civile. Il ordonnance les dépenses. \nLes représentants de l’Association doivent jouir du plein exercice de leurs droits civils. Le trésorier encaisse les recettes et acquitte les dépenses."),
            titre("6-DOTATION ET RESSOURCES \nANNUELLES",Colors.yellow),
            articles(500, 100, 14, "Elle comprend toute bien financier, matériel offert à l’Association."),
            articles(500,300, 15 ,"Les recettes annuelles de l’Union se composent : \n• Du revenu de ses biens à l’exception \n• Des cotisations des membres, personnes physiques et morales, des contributions des membres bienfaiteurs et des « Amis de l’ABER-SPB ».\n • Des subventions de l’Etat, des collectivités et des établissements publics. \n• Du produit des libéralités dont l’emploi est décidé au cours de l’exercice.\n• Du produit des ventes et rétributions pour services rendus."),
            articles(500,120,16, "Il est tenu une comptabilité faisant apparaître annuellement un compte de résultat, un bilan et une annexe."),
            articles(500, 100, 17, "Les statuts ne peuvent être modifiés par l’assemblée générale que sur proposition du bureau exécutif."),
            articles(500,200,18, "En cas de dissolution, l’assemblée générale désigne un ou plusieurs commissaires chargés de la liquidation des biens de l’Association. Elle attribue l’actif net à un ou plusieurs établissements analogues publics ou reconnus d’utilité publique."),
            titre("7-SURVEILLANCE ET \nREGLEMENT INTERIEUR", Colors.red),
            articles(500,200,19,"Le président doit faire connaître dans les trois mois après modification à l’ambassade du Bénin en Russie les changements survenus dans l’administration. Le rapport annuel est adressé chaque année à l’ambassade du Bénin en Russie, au HCB-Ru, a l’AEBR."),
            articles(500,150,20,"Le ministre de l’intérieur et le ministre des affaires étrangères et leurs délégués ont le droit de rendre visite à l’AEBR-SPB et de se faire rendre compte de leur fonctionnement."),
            articles(500,300,21,"Le règlement intérieur préparé par le bureau exécutif et adopté par l’assemblée générale précise notamment :\n - Le statut et la discipline des membres de l’Association ; \n - L’organisation de l’assemblée générale et du conseil d’administration ; \n - La participation des membres de l’Union à la vie civique des Français établis hors de France, notamment dans le cadre des activités des instances représentatives des Français établis hors de France. Il ne peut entrer en vigueur ni être modifié qu’après approbation du ministre de l’intérieur. Il est opposable aux membres de l’Union des Français de l’Etranger."),
          ],
        ),
      ),

    );


  }

  //this function allow us to create a padding with text //
  //widthPage for the width of the page
  //heightPage for the height of the page
  //N_article is for the number of article
  //article is the text article

  Padding articles(double widthPage , double heightPage ,int N_article ,String article){
    return Padding(padding: EdgeInsets.all(10),
    child: Container(
      width: widthPage,
      height: heightPage,
      decoration: BoxDecoration(
          color: Colors.green.shade400,
          borderRadius: BorderRadius.all(
              Radius.circular(20.0))),
      child: Center(

          child:  Padding(padding: EdgeInsets.all(10.0),
            child: RichText(text: TextSpan(
            text : 'Article $N_article : ',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),

              children: [
                TextSpan(text: article , style: TextStyle(fontWeight: FontWeight.normal)),
              ]
          ),
            textAlign: TextAlign.justify,
          ),)
      ),
    ),
    );
  }
  Padding titre(String titre , Color couleur){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child:  Container(
          width: 350,
          height: 75,
          decoration: BoxDecoration(
              color: couleur ,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(5.0)
              )),
          child:Center(

            child: Text(titre, style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            ),
          )

      ),

    );

  }



}
