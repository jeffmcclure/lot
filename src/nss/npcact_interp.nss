//////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - INTERPRETER for the CORE functions
//================================================================
// By Deva Bryson Winblood.   01/2003
//================================================================
// This is the interpreter that isolates a command and calls the
// appropriate functions to process the actions demanded by that
// command.  It also defines the MaxHB, and CState for each
// command so, that the NPCACT_STATES script will properly respond
// to these commands and handle them with the care required.
//////////////////////////////////////////////////////////////////
/*
    This script will have some functions internalized.
    Other functions will be called in NPCACT_INTERP_A, _B, etc.
    which is where the script has been broken into parts to
    facilitate expansion.
                                                            */
#include "npcactivitiesh"

////////////////////////////////
// GNB C States
////////////////////////////////
int NPCACT_CSTATE_DEFAULT = 0;// MaxHB or ACTION_INVALID
int NPCACT_CSTATE_FULLHB = 1; // Wait full MaxHB before next command
int NPCACT_CSTATE_NEXTAI = 2; // If ACTION INVALID process another command
int NPCACT_CSTATE_NEXT = 3;   // process another command
int NPCACT_CSTATE_WAIT = 4;   // Wait MaxHB unless interrupted


////////////////////////////////
// PROTOTYPES   ACT<scripts> = 5.0 NPCAction = 2.0+ NPCAct3 = 3.0 NPCAct4 =4.0
////////////////////////////////
void ACTSitChair();
void ACTUse();
void ACTTalk(int nMode=0);
void ACTSleep();
void ACTRest();
void ACTClose();
void ACTCloseC();
void ACTClean();
void NPCActionRandomInn();
void ACTCreateObject(string sRR);
void NPCActionRandomSpeak(int nParm);
void NPCActionPickPockets();
void NPCActionHealOthers();
void NPCActionTaunt();
void NPCActionEatNearbyFood();
void ACTRandomWalk();
void NPCActionBully();
void NPCActionProposition();
void NPCActionFollow(int nParm);
void NPCActionWorship(int nParm);
void NPCActionSing(int nParm);
void NPCActionAttackPlaceable();
void NPCActionLights(int nParm);
void NPCActionMagicEffect(int nParm);
void NPCActionAttackNearby();
void NPCActionTurnUndead();
void NPCActionHealSelf();
void NPCActionSetTrap();
void NPCActionRemoveTrap();
void NPCActionPickLock();
void NPCActionKnockSpell();
void NPCActionWakeupSleeper();
void NPCActionMakeCampfire();
void NPCActionSetVar(string sParm);
void NPCActionSayPhrase(string sParm);
void NPCActionCopyVar(string sParm);
void NPCActionIfStatement(string sParm);
void NPCActionAddTo(string sParm);
void NPCActionSubtractFrom(string sParm);
void NPCActionChangeClothes(string sParm);
void NPCActionSummonCreature(string sParm);
void NPCAct3Set(string sIn);
void NPCAct3Add(string sIn);
void NPCAct3Sub(string sIn);
void NPCAct3If(string sIn);
void ACTNewWaypoint(string sIn);
void ACTRandomCommand(string sIn);
void NPCActionFlee();
void ACTWait(string sIn);
void NPCActionCastSpell(string sSpell);
void NPCAct4ChangeC(string sIn);
void NPCAct4Locker(int nState);
void NPCAct4SetFacing(string sFacing);
void NPCAct4RandomDoor();
void NPCAct4Visual(int nState, string sVFX);
void NPCAct4Polymorph(string sPoly);
void NPCAct4React();
void NPCAct4SetListen();
void NPCAct4SetGossip(string sListen);
void NPCAct4Gossip();
void ACTScriptSet(string sIn);
void ACTBaseScripts(string sIn);
void ACTBeamEffect(string sIn);
void ACTCombat(string sIn);
void ACTFXAR(string sIn);
void ACTPFX(string sIn);
void ACTTake(string sIn);
void ACTMArea();
void ACTCPlaceable(string sIn);
void ACTDObject(string sIn);
void ACTAObject(string sIn);
void ACTSitS(string sIn);
void ACTLyrics(string sIn);
void ACTRSpeak(string sIn);
void ACTEffects(string sIn);
void ACTAnimate(string sIn);
void ACTTalkTo(string sIn);
void ACTFollowT(string sIn);
void ACTLibraryCall(string sIn);

void NADisable()
{
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" nGNBDisabled=TRUE");
  SetLocalInt(OBJECT_SELF,"nGNBDisabled",TRUE);
} // NADisable()

void NAEnable()
{
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" nGNBDisabled=FALSE");
  SetLocalInt(OBJECT_SELF,"nGNBDisabled",FALSE);
} // NAEnable()

////////////////////////////////////////////////////// MAIN ///////////////////
void main()
{
   struct stNPCLocals stGNB=GNBGetLocals(); // get parameters
   string sActions=stGNB.sGNBActions;
   string sWork;
   string sStore;
   object oMe=OBJECT_SELF;
   effect eEffect; // used for quick needs
   sWork=fnParsePeriod(sActions); // grab a command
   sActions=fnStripStringSize(sActions,sWork); // remove the command
   stGNB.sGNBActions=sActions;
   GNBSetLocals(stGNB);
   if (GetStringLength(sWork)<2) { sWork="00";stGNB.sGNBActions="";sActions=""; }
   string sL1=GetStringLeft(sWork,1); // first letter of command
   string sL2=GetStringLeft(sWork,2); // first two letters of command
   string sL4=""; // first 4 letters of the command
   string sR1=GetStringRight(sWork,1);
   int nR1=StringToInt(sR1);
   if (GetStringLength(sWork)>3) sL4=GetStringLeft(sWork,4);
   stGNB.nGNBHBCount=0;
   if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" Command:"+sWork);
   // process the command
   stGNB.sAct="";
   if (sL4=="NONE"||sL2=="00")
   { // do nothing
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=0;
   } // do nothing
   else if (sL1=="#")
   { // Custom Library
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     ACTLibraryCall(sWork);
     stGNB=GNBGetLocals();
   } // Custom Library
   else if (sWork=="SIT"||sWork=="SI")
   { // SIT in chair
     stGNB.nGNBCState=NPCACT_CSTATE_NEXTAI;
     stGNB.nGNBMaxHB=10;
     ACTSitChair();
   } // SIT in chair
   else if (sWork=="SITC"||sWork=="SC")
   { // SIT Crosslegged
     stGNB.nGNBCState=NPCACT_CSTATE_WAIT;
     stGNB.nGNBMaxHB=4;
     ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,60.0);
   } // SIT Crosslegged
   else if (sWork=="USE"||sWork=="US")
   { // USE nearby object
     stGNB.nGNBCState=NPCACT_CSTATE_NEXTAI;
     stGNB.nGNBMaxHB=3;
     GNBErrorReport(GetTag(OBJECT_SELF)+" USE PLACEABLE [[=======]]");
     ACTUse();
   } // USE nearby object
   else if (sWork=="TALK"||sWork=="TA")
   { // TALK - random method
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTTalk();
   } // TALK - random method
   else if (sWork=="TANM"||sWork=="TN")
   { // TALK NORMAL
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTTalk(1);
   } // TALK NORMAL
   else if (sWork=="TAFO"||sWork=="TF")
   { // TALK FORCEFUL
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTTalk(2);
   } // TALK FORCEFUL
   else if (sWork=="TAPL"||sWork=="TP")
   { // TALK PLEADING
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTTalk(3);
   } // TALK PLEADING
   else if (sWork=="TALA"||sWork=="TL")
   { // TALK LAUGHING
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTTalk(4);
   } // TALK LAUGHING
   else if (sWork=="SLEP"||sWork=="SL")
   { // Sleep
     stGNB.nGNBCState=NPCACT_CSTATE_NEXTAI;
     stGNB.nGNBMaxHB=10;
     ACTSleep();
   } // Sleep
   else if (sWork=="REST"||sWork=="RS")
   { // Rest
     stGNB.nGNBCState=NPCACT_CSTATE_NEXTAI;
     stGNB.nGNBMaxHB=10;
     ACTRest();
   } // Rest
   else if (sWork=="SALT"||sWork=="SA")
   { // Salute
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE,1.0,2.0);
   } // Salute
   else if (sWork=="CLEN"||sWork=="CL")
   { // Clean Up
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     ACTClean();
   } // Clean Up
   else if (sWork=="CLOS"||sWork=="CD")
   { // Close Door
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTClose();
   } // Close Door
   else if (sWork=="CLLD"||sWork=="CC")
   { // Close Container
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTCloseC();
   } // Close Container
   else if (sWork=="PICK"||sWork=="PP")
   { // Pick pockets
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionPickPockets();
   } // Pick pockets
   else if (sWork=="DRIN"||sWork=="DR")
   { // Drink Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0,4.0);
   } // Drink Animation
   else if (sWork=="INN"||sWork=="IN")
   { // INN/TAVERN Backwards compatible script
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionRandomInn();
   } // INN/TAVERN Backwards compatible script
   else if (sWork=="READ"||sWork=="RD")
   { // Read Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_READ,1.0,4.0);
   } // Read Animation
   else if (sWork=="LOW"||sWork=="LW")
   { // GET LOW Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=2;
     ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,4.0);
   } // GET LOW Animation
   else if (sWork=="MID"||sWork=="MD")
   { // GET MID Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=2;
     ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);
   } // GET MID Animation
   else if (sWork=="MEDI"||sWork=="ME")
   { // MEDITATION Animation
     stGNB.nGNBCState=NPCACT_CSTATE_WAIT;
     stGNB.nGNBMaxHB=2;
     ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,13.0);
   } // MEDITATION Animation
   else if (sWork=="HEAL"||sWork=="HE")
   { // HEAL NEARBY WOUNDED
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionHealOthers();
   } // HEAL NEARBY WOUNDED
   else if (sWork=="BOW"||sWork=="BW")
   { // BOW Animation
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,4.0);
   } // BOW Animation
   else if (sWork=="GRET"||sWork=="GR")
   { // GREETING Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING,1.0,4.0);
   } // GREETING Animation
   else if (sWork=="TAUN"||sWork=="TU")
   { // TAUNT nearby creatures
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionTaunt();
   } // TAUNT nearby creatures
   else if (sWork=="LIST"||sWork=="LI")
   { // LISTEN animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_LOOPING_LISTEN,1.0,4.0);
   } // LISTEN animation
   else if (sWork=="LOOK"||sWork=="LK")
   { // LOOK FAR Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0,4.0);
   } // LOOK FAR Animation
   else if (sWork=="DRUN"||sWork=="DK")
   { // DRUNK Animation
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,9.0);
   } // DRUNK Animation
   else if (sWork=="TIRD"||sWork=="TI")
   { // TIRED Animation
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0,9.0);
   } // TIRED Animation
   else if (sWork=="MEAT"||sWork=="C1")
   { // Create MEAT
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ACTCreateObject("nw_it_mmidmisc05");
   } // Create MEAT
   else if (sWork=="FISH"||sWork=="C2")
   { // Create FISH
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ACTCreateObject("nw_it_msmlmisc20");
   } // Create FISH
   else if (sWork=="ALE"||sWork=="C3")
   { // Create ALE
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ACTCreateObject("nw_it_mpotion021");
   } // Create ALE
   else if (sWork=="WINE"||sWork=="C4")
   { // Create WINE
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ACTCreateObject("nw_it_mpotion023");
   } // Create WINE
   else if (sWork=="SPRT"||sWork=="C5")
   { // Create Spirits
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ACTCreateObject("nw_it_mpotion022");
   } // Create Spirits
   else if (sWork=="EAT"||sWork=="EA")
   { // EAT nearby meat or fish
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionEatNearbyFood();
   } // EAT nearby meat or fish
   else if (sWork=="RAND"||sWork=="RW")
   { // Random Walk - does not use Bioware's
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     ACTRandomWalk();
   } // Random Walk - does not use Bioware's
   else if (GetStringLeft(sWork,3)=="EFF")
   { // Effects
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTEffects(sWork);
   } // Effects
   else if (sL4=="ANIM")
   { // Animate
     GNBSetLocals(stGNB);
     ACTAnimate(sWork);
     stGNB=GNBGetLocals();
     if (stGNB.nGNBMaxHB>1) stGNB.nGNBCState=NPCACT_CSTATE_FULLHB;
     else stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
   } // Animate
   else if (sL2=="TT")
   { // Talk To by TAG
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTTalkTo(sWork);
   } // Talk To by TAG
   else if (sL4=="FOTG"||sL2=="FT")
   { // Follow by TAG
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     GNBSetLocals(stGNB);
     ACTFollowT(sWork);
     stGNB=GNBGetLocals();
   } // Follow by TAg
   else if (sWork=="BULL"||sWork=="BU")
   { // BULLY
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionBully();
   } // BULLY
   else if (sL2=="CP")
   { // Create Placeable
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     ACTCPlaceable(sWork);
   } // Create Placeable
   else if (sL2=="AO")
   { // Attack object by tag
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     ACTAObject(sWork);
   } // Attack object by tag
   else if (sWork=="PROP"||sWork=="PR")
   { // PROPOSITION
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionProposition();
   } // PROPOSITION
   else if (sWork=="FOFM"||sWork=="FF")
   { // Follow Female NPC or PC
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=5;
     NPCActionFollow(0);
   } // Follow Female NPC or PC
   else if (sWork=="FOMA"||sWork=="FM")
   { // Follow Male NPC or PC
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=5;
     NPCActionFollow(1);
   } // Follow Male NPC or PC
   else if (sWork=="FOAN"||sWork=="FA")
   { // Follow Any NPC or PC
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=5;
     NPCActionFollow(2);
   } // Follow Any NPC or PC
   else if (sWork=="FOPC"||sWork=="FP")
   { // Follow Any PC
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=5;
     NPCActionFollow(3);
   } // Follow Any PC
   else if (sWork=="FOFP"||sWork=="Ff")
   { // Follow Female PC
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=5;
     NPCActionFollow(4);
   } // Follow Female PC
   else if (sWork=="FOMP"||sWork=="Fm")
   { // Follow Male PC
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=5;
     NPCActionFollow(5);
   } // Follow Male PC
   else if (sWork=="WORS"||sWork=="WS")
   { // WORSHIP Animation
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,9.0);
   } // WORSHIP Animation
   else if (sWork=="WOPC"||sWork=="WO")
   { // Worship PC
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=3;
     NPCActionWorship(0);
   } // Worship PC
   else if (sWork=="WOCR"||sWork=="WC")
   { // Worship Creature
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=3;
     NPCActionWorship(1);
   } // Worship Creature
   else if (sWork=="ATTK"||sWork=="AT")
   { // Attack nearby placeable
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionAttackPlaceable();
   } // Attack nearby placeable
   else if (sWork=="LTON"||sWork=="LO")
   { // Turn nearby lights ON
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionLights(0);
   } // Turn nearby lights ON
   else if (sWork=="LTOF"||sWork=="Lo")
   { // Turn nearby lights OFF
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionLights(1);
   } // Turn nearby lights OFF
   else if (GetStringLeft(sWork,3)=="MAG"||sL1=="M"&&GetStringLength(sWork)==2)
   {  // MAGIC effects
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionMagicEffect(StringToInt(GetStringRight(sWork,1))-1);
   }  // MAGIC effects
   else if (sWork=="KILL"||sWork=="KI")
   { // Attack nearby NPCs to Kill
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionAttackNearby();
   } // Attack nearby NPCs to Kill
   else if (GetStringLeft(sWork,5)=="LYRIC"||sL2=="LY")
   { // Lyrics
     stGNB.nGNBCState=NPCACT_CSTATE_FULLHB;
     stGNB.nGNBMaxHB=4;
     GNBSetLocals(stGNB);
     ACTLyrics(sWork);
     stGNB=GNBGetLocals();
   } // Lyrics
   else if (sWork=="DIE"||sWork=="DI")
   { // NPC Dies at this location
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     eEffect=EffectDeath(TRUE,TRUE);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEffect,OBJECT_SELF,200.0);
   } // NPC Dies at this location
   else if (sWork=="DISA"||sWork=="DS")
   { // DISAPPEAR EFFECT
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     eEffect=EffectDisappear();
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEffect,OBJECT_SELF,6.0);
   } // DISAPPEAR EFFECT
   else if (sWork=="REAP"||sWork=="Ra")
   { // REAPPEAR EFFECT
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     eEffect=EffectAppear();
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEffect,OBJECT_SELF,6.0);
   } // REAPPEAR EFFECT
   else if (sWork=="TURN"||sWork=="TR")
   { // TURN undead if any present
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionTurnUndead();
   } // TURN undead if any present
   else if (sWork=="SCRT"||sWork=="SH")
   { // SCRATCH HEAD Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0,4.0);
   } // SCRATCH HEAD Animation
   else if (sWork=="BORD"||sWork=="BO")
   { // BORED Animation
     stGNB.nGNBCState=NPCACT_CSTATE_NEXTAI;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED,1.0,4.0);
   } // BORED Animation
   else if (GetStringLeft(sWork,3)=="RNS"||(sL1=="R"&&GetStringLength(sWork)==2))
   { // Random Speaking - all
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     if (GetStringRight(sWork,1)=="0")
     {
       NPCActionRandomSpeak(9);
     }
     else
     {
       NPCActionRandomSpeak(StringToInt(GetStringRight(sWork,1))-1);
     }
   } // Random Speaking - all
   else if (sWork=="VIC1"||sWork=="V1")
   { // Victory Animation 1
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0,3.0);
   } // Victory Animation 1
   else if (sWork=="VIC2"||sWork=="V2")
   { // Victory Animation 2
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2,1.0,3.0);
   } // Victory Animation 2
   else if (sWork=="VIC3"||sWork=="V3")
   { // Victory Animation 3
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3,1.0,3.0);
   } // Victory Animation 3
   else if (sWork=="PAU1"||sWork=="P1")
   { // Pause Animation 1
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,3.0);
   } // Pause Animation 1
   else if (sWork=="PAU2"||sWork=="P2")
   { // Pause Animation 2
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,1.0,3.0);
   } // Pause Animation 2
   else if (sWork=="POIS"||sWork=="PO")
   { // POISON Effect
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     eEffect=EffectPoison(POISON_TINY_SPIDER_VENOM);
     ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,30.0));
   } // POISON Effect
   else if (sWork=="HELT"||sWork=="HS")
   { // Heal self
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionHealSelf();
   } // Heal Self
   else if (sWork=="STTR"||sWork=="ST")
   { // SET TRAP
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionSetTrap();
   } // SET TRAP
   else if (sWork=="RMTR"||sWork=="RT")
   { // REMOVE TRAP
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionRemoveTrap();
   } // REMOVE TRAP
   else if (sWork=="PKLK"||sWork=="PK")
   { // PICK LOCK
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionPickLock();
   } // PICK LOCK
   else if (sWork=="KNOC"||sWork=="KN")
   { // Cast KNOCK Spell
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionKnockSpell();
   } // Cast KNOCK Spell
   if (GetStringLeft(sWork,3)=="SNG"||(sL1=="r"&&GetStringLength(sWork)==2))
   { // random singing
     stGNB.nGNBCState=NPCACT_CSTATE_FULLHB;
     stGNB.nGNBMaxHB=12;
     NPCActionSing(StringToInt(GetStringRight(sWork,1))-1);
   } // random singing
   else if (sWork=="CLAC"||sWork=="ca")
   { // ClearAllActions()
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     AssignCommand(OBJECT_SELF,ClearAllActions());
   } // ClearAllActions()
   else if (sWork=="WAKE"||sWork=="WK")
   { // Wakeup nearby sleeping NPCs
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionWakeupSleeper();
   } // Wakeup nearby sleeping NPCs
   else if (sWork=="HELP"||sWork=="HP")
   { // Call for HELP
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
   } // Call for HELP
   else if (sWork=="CAMP"||sWork=="CF")
   { // Make a Campfire
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     NPCActionMakeCampfire();
   } // Make a Campfire
   else if (sWork=="FLEE"||sWork=="FL")
   { // FLEE if enemies are nearby
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=3;
     NPCActionFlee();
   } // FLEE if enemies are nearby
   else if (GetStringLeft(sWork,3)=="RWL"||sL2=="RW")
   { // Random Speak
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTRSpeak(sWork);
   } // Random Speak
   else if (sL4=="SITS")
   { // Sit for specified amount of time
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     GNBSetLocals(stGNB);
     ACTSitS(sWork);
     stGNB=GNBGetLocals();
   } // Sit for specified amount of time
   else if (sWork=="EQ")
   { // EQUIP WEAPONS
     stGNB.nGNBCState=NPCACT_CSTATE_WAIT;
     stGNB.nGNBMaxHB=1;
     if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" EQUIP");
     AssignCommand(oMe,ActionEquipMostEffectiveArmor());
     AssignCommand(oMe,ActionEquipMostDamagingMelee(GetFirstPC()));
   } // EQUIP WEAPONS
   else if (sWork=="UE")
   { // UNEQUIP WEAPONS
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" UNEQUIP");
     ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
     ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
   } // UNEQUIP WEAPONS
   else if (sWork=="LOCK"||sWork=="lk")
   { // LOCK nearby door or container
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCAct4Locker(TRUE);
   } // LOCK nearby door or container
   else if (sWork=="UNLOCK"||sWork=="ul")
   { // UNLOCK nearby door or container
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCAct4Locker(FALSE);
   } // UNLOCK nearby door or container
   else if (sWork=="SLIS"||sWork=="sl")
   { // Set Listen for GOSSIP
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4SetListen();
   } // Set Listen for GOSSIP
   else if (sWork=="REACT"||sWork=="RT")
   { // React to changes in area
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCAct4React();
   } // React to changes in area
   else if (sWork=="DRD"||sWork=="DD")
   { // Choose nearby door as next destination point
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4RandomDoor();
   } // choose nearby door as next destination point
   else if (sWork=="NONP"||sWork=="NN")
   { // Set no interaction with NPCs
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     stGNB.nNN=TRUE;
     GNBSetLocals(stGNB);
   } // Set no interaction with NPCs
   else if (sWork=="YSNP"||sWork=="YN")
   { // Turn NPC interaction back on
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     stGNB.nNN=FALSE;
     GNBSetLocals(stGNB);
   } // Turn NPC interaction back on
   else if (sL2=="DO")
   { // Destroy Object within 8 meters by tag
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTDObject(sWork);
   } // Destroy Object within 8 meters by taf
   else if (sWork=="GOSSIP"||sWork=="GO")
   { // GOSSIP
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4Gossip();
   } // GOSSIP
   else if (sL4=="SGOS"||sL2=="sg")
   { // Set Gossip
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4SetGossip(sWork);
   } // Set Gossip
   else if (sL4=="SFAC"||sL2=="SF")
   { // Set Facing
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4SetFacing(sWork);
   } // Set Facing
   else if (sL2=="CB")
   { // Enter combat with specific object by tag
     stGNB.nGNBCState=NPCACT_CSTATE_WAIT;
     stGNB.nGNBMaxHB=3;
     if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" CB parsed");
     ACTCombat(sWork);
   } // Enter combat with specific object by tag
   else if (GetStringLeft(sWork,3)=="SUM"||sL1=="m")
   { // Summon Monster
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     NPCActionSummonCreature(sWork);
   } // Summon Monster
   else if ((GetStringLeft(sWork,3)=="SAY")||((sL1=="S"&&GetStringLength(sWork)==2)&&(nR1!=0)))
   { // SAY one liner
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionSayPhrase(sWork);
   } // SAY one liner
   else if (GetStringLength(sWork)==4&&sL1=="S")
   { // 3.0 Subtraction
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionSubtractFrom(sWork);
   } // 3.0 Subtraction
   else if (GetStringLeft(sWork,3)=="VFX"||sL2=="VF")
   { // Visual FX
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4Visual(1,sWork);
   } // Visual FX
   else if (sL4=="RVFX"||sL2=="RV")
   { // Remove Visual FX
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4Visual(0,sWork);
   } // Remove Visual FX
   else if (GetStringLength(sWork)==4&&sL1=="V")
   { // 3.0 Variable Set command
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionSetVar(sWork);
   } // 3.0 Variable Set command
   else if (GetStringLength(sWork)==4&&sL1=="A")
   { // 3.0 Addition
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionAddTo(sWork);
   } // 3.0 Addition
   else if (GetStringLength(sWork)==4&&sL1=="I")
   { // 3.0 IF
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     NPCActionIfStatement(sWork);
     stGNB=GNBGetLocals();
   } // 3.0 IF
   else if (GetStringLeft(sWork,3)=="COP"||sL1=="c")
   { // 3.0 COPY
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionCopyVar(sWork);
   } // 3.0 COPY
   else if (sL2=="CO")
   { // Create Object
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     sStore=GetStringRight(sWork,GetStringLength(sWork)-2);
     ACTCreateObject(sStore);
   } // Create Object
   else if (GetStringLeft(sWork,4)=="WAIT"||sL2=="WT")
   { // WAIT
     stGNB.nGNBCState=NPCACT_CSTATE_FULLHB;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     ACTWait(sWork);
     stGNB=GNBGetLocals();
   } // WAIT
   else if (sL2=="WP")
   { // Waypoint Specific
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     ACTNewWaypoint(sWork);
     stGNB=GNBGetLocals();
   } // Waypoint Specific
   else if (GetStringLeft(sWork,3)=="CLO"||sL1=="W")
   { // 3.0 Change Clothing
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCActionChangeClothes(sWork);
   } // 3.0 Change Clothing
   else if (sL1=="@")
   { // @ Custom script
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     ExecuteScript(GetStringRight(sWork,GetStringLength(sWork)-1),OBJECT_SELF);
     stGNB=GNBGetLocals();
   } // @ Custom script
   else if (sL2=="RC")
   { // Random Command
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     ACTRandomCommand(sWork);
     stGNB=GNBGetLocals();
   } // Random Command
   else if (sL1=="!")
   { // SET VARIABLE
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     NPCAct3Set(sWork);
     stGNB=GNBGetLocals();
   } // SET VARIABLE
   else if (sL1=="+")
   { // Addition
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     NPCAct3Add(sWork);
     stGNB=GNBGetLocals();
   } // Addition
   else if (sL1=="-")
   { // Subtraction
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     NPCAct3Sub(sWork);
     stGNB=GNBGetLocals();
   } // Subtraction
   else if (sL1=="&")
   { // IF
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     GNBSetLocals(stGNB);
     NPCAct3If(sWork);
     stGNB=GNBGetLocals();
   } // IF
   else if (sL4=="CAST"||sL2=="C/")
   { // CAST Spell
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     if (sL4=="CAST") sStore=GetStringRight(sWork,GetStringLength(sWork)-4);
     else sStore=GetStringRight(sWork,GetStringLength(sWork)-2);
     NPCActionCastSpell(sStore);
   } // CAST Spell
   else if (GetStringLeft(sWork,3)=="LAG"||sL1=="L")
   { // LAG Commands
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     sStore=GetStringRight(sWork,1);
     stGNB.nGNBLagMeth=StringToInt(sStore);
   } // LAG Commands
   else if (sL2=="Cc")
   { // Change Clothes
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     NPCAct4ChangeC(sWork);
   } // Change Clothes
   else if (sL2=="CO")
   { // Create Object
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTCreateObject(GetStringRight(sWork,GetStringLength(sWork)-2));
   } // Create Object
   else if (sL4=="POLY"||sL2=="PY")
   { // Polymorph
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=1;
     NPCAct4Polymorph(sWork);
   } // Polymorph
   else if (sL2=="BS")
   { // Set BASE SCRIPTS
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTBaseScripts(sWork);
   } // Set BASE SCRIPTS
   else if (sL1=="$")
   { // Set specific script
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTScriptSet(sWork);
   } // Set specific script
   else if (sL2=="BM")
   { // Apply Beam Effect to object by TAG
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTBeamEffect(sWork);
   } // Apply Beam Effect to Object by TAG
   else if (sL2=="FX"||sL4=="FXAR")
   { // Apply effect to object
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTFXAR(sWork);
   } // Apply effect to object
   else if (sL2=="PF")
   { // Apply persistent effect
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTPFX(sWork);
   } // Apply persistent effect
   else if (sL2=="TK"||sL4=="TAKE")
   { // Take item by tag
     stGNB.nGNBCState=NPCACT_CSTATE_DEFAULT;
     stGNB.nGNBMaxHB=2;
     ACTTake(sWork);
   } // Take item by tag
   else if (sL2=="MA"||sWork=="MAREA")
   { // Make area monitor
     stGNB.nGNBCState=NPCACT_CSTATE_NEXT;
     stGNB.nGNBMaxHB=1;
     ACTMArea();
   } // Make area monitor
   GNBSetLocals(stGNB);
}
////////////////////////////////////////////////////// MAIN ///////////////////

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// SUPPORT FUNCTIONS ///////////////////////////
///////////////////////////////////////////////////////////////////////////////
object GetNearestObjectMatch(int nType,string sPattern,object oTo,int nN,float fRange=0.0)
{ // Get an object with its TAG matching pattern
  int nC=1;
  int nO=0;
  int nFound=FALSE;
  float fDist;
  object oOb=GetNearestObject(nType,oTo,nC);
  while (oOb!=OBJECT_INVALID&&nC<=NPCACT_MAX_SCAN&&!nFound)
  { // test
    if (DEEP_DEBUG_ON) GNBErrorReport("Test #:"+IntToString(nC)+" is '"+GetTag(oOb)+"' dist="+FloatToString(GetDistanceBetween(oOb,oTo)));
    if (TestStringAgainstPattern(sPattern,GetTag(oOb)))
    { // pattern matches
      if (fRange!=0.0)
      { // must be within range
        fDist=GetDistanceBetween(oOb,oTo);
        if (fDist<=fRange)
        { // it is a good target
          if (DEEP_DEBUG_ON) GNBErrorReport("MATCH");
          nO++;
          if (nO==nN) nFound=TRUE;
        } // it is a good target
      } // must be within range
      else
      {
       nO++;
       if (nO==nN) nFound=TRUE;
      }
    } // pattern matches
    if (!nFound)
    {
      nC++;
      oOb=GetNearestObject(nType,oTo,nC);
    }
  } // test
  if (nFound) return oOb;
  return OBJECT_INVALID;
} // GetNearestObjectMatch()

void GNBRemoveEffect(int nEffectType, object oTarget=OBJECT_SELF)
{
  effect eCheck=GetFirstEffect(oTarget);
  while(GetIsEffectValid(eCheck))
  { //
    if (GetEffectType(eCheck)==nEffectType)
      AssignCommand(oTarget,RemoveEffect(oTarget,eCheck));
    eCheck=GetNextEffect(oTarget);
  } //
} // GNBRemoveEffect()



///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// ACTIVITIES /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


//--------------------------------------------[ SIT CHAIR ]------------------
void ACTSitChair()
{ // Sit in the nearest available sitable object
  int nC=1;
  object oChair=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
     "(Chair|Couch|Stool|BenchPew|ThroneEvil|ThroneGood|InvisChair)",
     OBJECT_SELF,nC,5.0);
  while (oChair!=OBJECT_INVALID&&GetSittingCreature(oChair)!=OBJECT_INVALID)
  { // find an empty chair
    nC++;
    oChair=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
     "(Chair|Couch|Stool|BenchPew|ThroneEvil|ThroneGood|InvisChair)",
     OBJECT_SELF,nC,5.0);
  } // find an empty chair
  if (oChair!=OBJECT_INVALID)
  { // move and sit
    ActionMoveToObject(oChair);
    ActionSit(oChair);
  } // move and sit
} // SitChair()

//----------------------------------------------------[ USE ]---------------
void ACTUse()
{ // Use nearby object
  int nC=1;
  int nFound=FALSE;
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" USE");
  object oUse=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
       "**",OBJECT_SELF,nC,8.0);
  while(oUse!=OBJECT_INVALID&&!nFound)
  { // make sure it is usable
     if (DEEP_DEBUG_ON) GNBErrorReport("  #"+IntToString(nC)+" PLACEABLE:"+GetName(oUse));
     if (GetUseableFlag(oUse)==TRUE) nFound=TRUE;
     else
     {
       nC++;
       oUse=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
       "**",OBJECT_SELF,nC,8.0);
     }
  } // make sure it is usable
  if (oUse!=OBJECT_INVALID)
  {
    ActionMoveToObject(oUse);
    ActionDoCommand(SetFacingPoint(GetPosition(oUse)));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);
    ActionInteractObject(oUse);
  }
} // ACTUse()

//-------------------------------------------------[ TALK ALL ]--------------
void ACTTalk(int nMode=0)
{ // TALK 0=random, 1=normal, 2=forceful, 3=pleading, 4=laughing
  int nType=nMode;
  if (nType==0) nType=d4();
  int nC=1;
  int nFound=FALSE;
  int nAnim=ANIMATION_LOOPING_TALK_NORMAL;
  if (nType==2) nAnim=ANIMATION_LOOPING_TALK_FORCEFUL;
  else if (nType==3) nAnim=ANIMATION_LOOPING_TALK_PLEADING;
  else if (nType==4) nAnim=ANIMATION_LOOPING_TALK_LAUGHING;
  object oTarget;
  int nNN=GetLocalInt(OBJECT_SELF,"nNN"); // NO NPC flag
  oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nC,15.0);
  while(oTarget!=OBJECT_INVALID&&!nFound)
  { // seek target
    if ((GetIsPC(oTarget)==FALSE&&nNN==TRUE)||IsInConversation(oTarget))
    { // keep looking
      nC++;
      oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nC,15.0);
    } // keep looking
    else
     nFound=TRUE;
  } // seek target
  if (nFound==TRUE)
  { // do talk
    ActionMoveToObject(oTarget);
    ActionDoCommand(SetFacingPoint(GetPosition(oTarget)));
    ActionPlayAnimation(nAnim,1.0,4.0);
    ActionStartConversation(oTarget);
  } // do talk
} // ACTTalk()


void ActiveSleepFX(object oMe)
{
  if(GetLocalInt(oMe,"nGNBSleeping")==TRUE)
  {
    effect eSleep=EffectSleep();
    effect eSleepFX=EffectVisualEffect(VFX_IMP_SLEEP);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,oMe,24.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleepFX,oMe,24.0);
    DelayCommand(18.0,ActiveSleepFX(oMe));
  }
}

//---------------------------------------------------[ SLEP ]---------------
void ACTSleep()
{ // sleep
  SetLocalInt(OBJECT_SELF,"nGNBSleeping",TRUE);
  ActiveSleepFX(OBJECT_SELF);
  DelayCommand(115.0,SetLocalInt(OBJECT_SELF,"nGNBSleeping",FALSE));
} // ACTSleep()

//-------------------------------------------------[ REST ]-----------------
void ACTRest()
{ // Rest - this can be disturbed
 ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,130.0);
 effect eSleep=EffectVisualEffect(VFX_IMP_SLEEP);
 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,OBJECT_SELF,120.0);
} // ACTRest()

//------------------------------------------------[ CLOS ]------------------
void ACTClose()
{ // Close nearby door
  object oDoor;
  int nC=1;
  oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nC,8.0);
  while(oDoor!=OBJECT_INVALID)
  { // look for open doors
    if (GetIsOpen(oDoor))
    { // Close it
      ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.5);
      AssignCommand(oDoor,ActionCloseDoor(oDoor));
    } // close it
    nC++;
    oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nC,8.0);
  } // look for open doors
} // ACTClose()

//-------------------------------------------------[ CLEN ]-----------------
void ACTClean()
{ // Cleanup non-plot items lying around
  int nFound=FALSE;
  int nC=1;
  object oItem=GetNearestObjectMatch(OBJECT_TYPE_ITEM,"**",OBJECT_SELF,nC,8.0);
  while(oItem!=OBJECT_INVALID&&!nFound)
  { // look for item
    if (GetPlotFlag(oItem)==FALSE) nFound=TRUE;
    else
    {
     nC++;
     oItem=GetNearestObjectMatch(OBJECT_TYPE_ITEM,"**",OBJECT_SELF,nC,8.0);
    }
  } // look for item
  if (nFound)
  {
    ActionPickUpItem(oItem);
    ActionDoCommand(DestroyObject(oItem));
  }
} // ACTClean()

//------------------------------------------------[ CLLD ]------------------
void ACTCloseC()
{ // Close nearby container
  object oDoor;
  int nC=1;
  int nFound=FALSE;
  oDoor=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,"**",OBJECT_SELF,nC,8.0);
  while(oDoor!=OBJECT_INVALID&&!nFound)
  { // look for open doors
    if (GetIsOpen(oDoor)) nFound=TRUE;
    else
    {
      nC++;
      oDoor=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,"**",OBJECT_SELF,nC,8.0);
    }
  } // look for open doors
  if (nFound)
  { // close the door
    ActionMoveToObject(oDoor);
    DelayCommand(1.0,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.5));
    DelayCommand(2.5,AssignCommand(oDoor,ActionCloseDoor(oDoor)));
  } // close the door
} // ACTCloseC()

//-------------------------------------------------[ INN ]------------------
void NPCActionRandomInn()
{
  int nAct=Random(5)+1;
  object oDest;
  string sMsg;
  string sTag="INN_";
  int nTest;
  switch(nAct)
  { // nAct
    case 1: sTag=sTag+"BARTENDER"; break;
    case 2: sTag=sTag+"BAR"; break;
    case 3: sTag=sTag+"TABLE"; break;
    case 4: sTag=sTag+"BARMAID"; break;
    case 5:
    default: sTag=sTag+"GROUP"; break;
  } // nAct
  oDest=GetNearestObjectByTag(sTag,OBJECT_SELF,1);
  if (oDest!=OBJECT_INVALID)
  { // !OI
    ActionMoveToObject(oDest,FALSE,1.0);
    switch(nAct)
    { // action
      case 1: {
        nTest=d6();
        if (nTest==1) sMsg="Haha you have some mighty fine drinks.";
        else if (nTest==2) sMsg="I'll have another ale down here!";
        else if (nTest==3) sMsg="This is the life.  It beats workin'.";
        else if (nTest==4) sMsg="It's spirits that I'll be drinkin'";
        else if (nTest==5) sMsg="I saysh itsss mines... gets back. Go getsss yourss own.";
        else if (nTest==6) sMsg="I betsss I kin drink yousss into unconciousness.";
        ActionSpeakString(sMsg);
        break;
      } // Bartender
      case 2: {
       nTest=d4();
       if (nTest==1) sMsg="Give me a spirtsssssss.  Haha didss you hear how many sssssssss essss I said.  Haha";
       else if (nTest==2) sMsg="A little meat here for my drink to cling to if you please.";
       else if (nTest==3) sMsg="Kin I'sss haves another drinkssss on credit?";
       else sMsg="That is good stuff.";
       ActionSpeakString(sMsg);
       break;
      } // BAR
      case 3: {
       nTest=d4();
       sMsg="hic";
       if (nTest==1) ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,8.0);
       else if (nTest==2) ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0,3.0);
       else if (nTest==3) sMsg="I might need another drink.";
       else if (nTest==4) sMsg="Tis' a good night for drinking with my friends.";
       ActionSpeakString(sMsg);
       break;
      } // TABLE
      case 4: {
       nTest=d6();
       sMsg="Your a fine wench. Hic.";
       if (nTest==1) ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,5.0);
       else if (nTest==2) ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING,1.0,4.0);
       else if (nTest==3) sMsg="Hoy!!!! I need a drink!";
       else if (nTest==4) sMsg="Your not watering this down are ya?";
       else if (nTest==5) sMsg="A drink today, will save the day!!";
       else if (nTest==6) sMsg="What do you mean I've been cut off? The nigh is still young! Hic.";
       ActionSpeakString(sMsg);
       break;
      } // BARMAID
      case 5: {
       nTest=d6();
       sMsg="I tell you it is true!!";
       if (nTest==1) ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,5.0);
       else if (nTest==2) ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0,3.0);
       else if (nTest==3) ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,3.0);
       else if (nTest==4) sMsg="That's what they always say.";
       else if (nTest==5) sMsg="Go on drink some more.";
       else if (nTest==6) sMsg="This beats work don't it?";
       ActionSpeakString(sMsg);
      break;
      } // GROUP
    } // action
  } // !OI
} // NPCActionRandomInn()

//------------------------------------------[ CREATE OBJECT ]---------------
void ACTCreateObject(string sRR)
{ // Create the object specified by resref
  // Try to place is on a NPCACT_CREATE_HERE waypoint if one is close
  object oWP=GetNearestObjectMatch(OBJECT_TYPE_WAYPOINT,
                  "NPCACT_CREATE_HERE",OBJECT_SELF,1,5.0);
  object oItem;
  if (oWP!=OBJECT_INVALID)
  { // put at the location
   ActionMoveToObject(oWP);
   ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
   oItem=CreateObject(OBJECT_TYPE_ITEM,sRR,GetLocation(oWP),TRUE);
  } // put at the location
  else
  { // make it and put it down
    oItem=CreateItemOnObject(sRR);
    ActionPutDownItem(oItem);
  } // make it and put it down
} // ACTCreateObject()

//-------------------------------------------[ Random Speak ]---------------
//-------------------------------------------------
void NPCActionRandomSpeak(int nParm)
{
  string sSayThis="I really don't know what to say.";
  int nSayNum=Random(9);
  switch (nParm)
  { // switch
   case 0: { // Mercenary
    if(nSayNum==0) sSayThis="Don't it beat all! That merchant took forever to get here.";
    else if(nSayNum==1) sSayThis="I just done my sword cleanin' fo' the day.";
    else if(nSayNum==2) sSayThis="I seen an ogre once that'd shrivel yo' privates if he took to lookin' at ya.";
    else if(nSayNum==3) sSayThis="Some of the walkin' all day wears me down.";
    else if(nSayNum==4) sSayThis="A nice ale usually settles me stomach.";
    else if(nSayNum==5) sSayThis="Once I had to fight off a dozen bandits comin' fo' the merchant I was workin' wif.";
    else if(nSayNum==6) sSayThis="I need to find me a bed warmer. Harhar.";
    else if(nSayNum==7) sSayThis="I think spirits is a stronger drink. That'd be what I needs.";
    else if(nSayNum==8) sSayThis="I have a big scar on me arse too.  Damn badger bit it.";
    break;
   } // Mercenary
  case 1: { // Merchant
    if(nSayNum==0) sSayThis="Come look at my goods.";
    else if(nSayNum==1) sSayThis="I'm looking to trade.";
    else if(nSayNum==2) sSayThis="Fresh in!  Goods from around the world.";
    else if(nSayNum==3) sSayThis="Come one, Come all.  Incredible bargains here.";
    else if(nSayNum==4) sSayThis="Do you need to lighten your load? I'm buying goods of all kinds.";
    else if(nSayNum==5) sSayThis="Quick! Get them before they are gone.  I am selling them like they are jewels.  Maybe they are.";
    else if(nSayNum==6) sSayThis="I have money just waiting to be spent on your goods you wish to sell.";
    else if(nSayNum==7) sSayThis="Buy something for a special occasion!";
    else if(nSayNum==8) sSayThis="Did you forget something? You better talk to me to make sure you didn't.";
    break;
  } // Merchant
  case 2: { // Bard
    if (nSayNum==0) sSayThis="Ode to the poor minded beggar.  A tale of woe an pitty.";
    else if(nSayNum==1) sSayThis="O' to travel the world and find new tales.";
    else if(nSayNum==2) sSayThis="Too many words can tangle the tongue.  A well placed word though, that can win wars.";
    else if(nSayNum==3) sSayThis="If booglytoosome would fondangle the biddyswitch twould ever so simply perdobel.";
    else if(nSayNum==4) sSayThis="It twas a dark and stormy night...  No that sounds too cliche like.";
    else if(nSayNum==5) sSayThis="So many stories, so many songs, and far too little time.";
    else if(nSayNum==6) sSayThis="The orphan dwarf and his adoptive troll parents... nah, that sounds too stupid.";
    else if(nSayNum==7) sSayThis="Time pursues us all.  It follows and cuddles.  It waits for to fall.  Our bodies form as puddles...  That is just awful.";
    else if(nSayNum==8) sSayThis="A song or two to lighten the day.  A coin or two to guide my way.";
    break;
  } // Bard
  case 3: { // Monsters
    if (nSayNum==0) sSayThis="Me findem food.  Is good?";
    else if(nSayNum==1) sSayThis="Me needs me mate.  Is good?";
    else if(nSayNum==2) sSayThis="Me bash things. Is good?";
    else if(nSayNum==3) sSayThis="Smell man flesh.";
    else if(nSayNum==4) sSayThis="No like rain.";
    else if(nSayNum==5) sSayThis="Needs more blood.";
    else if(nSayNum==6) sSayThis="Time for bash.";
    else if(nSayNum==7) sSayThis="Me say NOW!";
    else if(nSayNum==8) sSayThis="Shiny things good.  Man flesh trap.";
    break;
   } // Monsters
  case 4: { // Female
    if (nSayNum==0) sSayThis="I really don't like this outfit.";
    else if(nSayNum==1) sSayThis="Today is depressing.";
    else if(nSayNum==2) sSayThis="I think I need to work on my hair.";
    else if(nSayNum==3) sSayThis="I wonder who that is?";
    else if(nSayNum==4) sSayThis="Did you hear who slept over at you know who's last night?";
    else if(nSayNum==5) sSayThis="My man will support me well.";
    else if(nSayNum==6) sSayThis="I need some new clothes.";
    else if(nSayNum==7) sSayThis="It's just not my day.";
    else if(nSayNum==8) sSayThis="Damn the fates.";
    break;
   } // Female
  case 5: { // Male
    if (nSayNum==0) sSayThis="Did you see her melons? Whoa.";
    else if(nSayNum==1) sSayThis="She has a nice arse.  I'm talking about her donkey either.";
    else if(nSayNum==2) sSayThis="I got a new tool last week.";
    else if(nSayNum==3) sSayThis="Some weather we're having.";
    else if(nSayNum==4) sSayThis="I hate work.";
    else if(nSayNum==5) sSayThis="I bet I can belch longer.";
    else if(nSayNum==6) sSayThis="No pain, no gain.";
    else if(nSayNum==7) sSayThis="A fool and his money are soon parted.";
    else if(nSayNum==8) sSayThis="If it don't hurt nothin' do what you want.";
    break;
   } // Male
  case 6: { // Magecraft
    if (nSayNum==0) sSayThis="A well placed grease spell often works wonders.";
    else if(nSayNum==1) sSayThis="What spell would you use in that situation?";
    else if(nSayNum==2) sSayThis="I almost am done with that new spell.";
    else if(nSayNum==3) sSayThis="What do I NEED an invisible stalker for?";
    else if(nSayNum==4) sSayThis="The usual spell does fine for me.";
    else if(nSayNum==5) sSayThis="...and then I put the bat guano in with the other powder and...";
    else if(nSayNum==6) sSayThis="...the explosion was quite magnificent.  It only singed my hair a bit.";
    else if(nSayNum==7) sSayThis="It worked last time I cast it.";
    else if(nSayNum==8) sSayThis="I'm not sure the situation calls for an answer to that.";
    break;
   } // Magecraft
  case 7: { // Religion
    if(nSayNum==0) sSayThis="...and so what is the universe really?";
    else if(nSayNum==1) sSayThis="...does not preclude the existence of other gods.";
    else if(nSayNum==2) sSayThis="Yes, but that in itself was a contradiction.";
    else if(nSayNum==3) sSayThis="For the love of the gods. Read the book.  It's all in there.";
    else if(nSayNum==4) sSayThis="I'm telling you it is a hidden truth.";
    else if(nSayNum==5) sSayThis="How can you ask such silly questions?";
    else if(nSayNum==6) sSayThis="That is blasphemy if I ever heard it before.";
    else if(nSayNum==7) sSayThis="...might be the reason why...";
    else if(nSayNum==8) sSayThis="...could of been a miracle...";
    break;
   } // Religion
  case 8: { // Commoner
    if(nSayNum==0) sSayThis="What do you think of the weather?";
    else if(nSayNum==1) sSayThis="I don't give it much thought really.";
    else if(nSayNum==2) sSayThis="How has your day been?";
    else if(nSayNum==3) sSayThis="The same as usual.";
    else if(nSayNum==4) sSayThis="That's what she wanted to know.";
    else if(nSayNum==5) sSayThis="I don't know.";
    else if(nSayNum==6) sSayThis="You win some.  Others you lose.";
    else if(nSayNum==7) sSayThis="What did they give you?";
    else if(nSayNum==8) sSayThis="I think something special.";
    break;
   } // Commoner
   case 9: { // Drunk
    if (nSayNum==0) sSayThis="Thisss sho' isss a nice place.";
    else if (nSayNum==1) sSayThis="One moresss drinksss sho to help me walk.  Hic.";
    else if (nSayNum==2) sSayThis="Thatsss a mighty fine barrel you havess. Hicup.";
    else if (nSayNum==3) sSayThis="Who took my drink? Hic.";
    else if (nSayNum==4) sSayThis="Itsss a bad day I need a drink.";
    else if (nSayNum==5) sSayThis="[SINGING] Grannies in the cellar, lordy can't ya smell her.";
    else if (nSayNum==6) sSayThis="My bottle looksss shorter than before.";
    else if (nSayNum==7) sSayThis="Spirits is the breakfast of champions!! Let me have some.  Hicup.";
    else if (nSayNum==8) sSayThis="Uggghhhh... I don't feel too goodss.  Hic.";
    break;
   } // Drunk
   default: break;
  } // switch
  ActionSpeakString(sSayThis,TALKVOLUME_TALK);
} // NPCActionRandomSpeak()

//----------------------------------------------[ PICK POCKETS ]--------------
void NPCACTPP(object oTarget)
{
  float fDist=GetDistanceBetween(oTarget,OBJECT_SELF);
  if (fDist<3.0&&fDist!=0.0)
  {
    int nCheck= (d20()+(GetSkillRank(SKILL_PICK_POCKET, OBJECT_SELF))) - (d20()+(GetSkillRank(SKILL_SPOT,oTarget)));
    if (nCheck>0)
    { // success
       TakeGoldFromCreature(Random(20)+1,oTarget,FALSE);
       if(GetIsPC(oTarget))
        DelayCommand(60.0,SendMessageToPC(oTarget,"You have been robbed."));
       ActionMoveAwayFromObject(oTarget,FALSE,20.0);
    } // success
    else if (nCheck<-2)
    { // failed and noticed
     if (GetIsPC(oTarget))
      SendMessageToPC(oTarget,GetName(OBJECT_SELF)+" attempted to pick your pocket.");
     else
      { // NPC noticed
        ActionMoveAwayFromObject(oTarget,TRUE,20.0);
        string sRandStatement="That's right run away you scoundrel!";
        switch(Random(4))
          { // switch
          case 0: sRandStatement="You thief!! Next time I see you I'll...";
           break;
          case 1: sRandStatement="Stop! That thief just tried to rob me.";
           break;
          case 2: sRandStatement="You highway robber! I'm warning the authorities about you.";
           default: break;
          }// switch
         AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,2.0));
         AssignCommand(oTarget,ActionSpeakString(sRandStatement));
      } // NPC Noticed
    } // failed and noticed
   }
} // NPCACTPP - PickPockets Support

void NPCActionPickPockets()
{ // takes random 1-20 gold pieces
  object oTarget;
  int nLoop=1;
  //SendMessageToPC(GetFirstPC(),"PickPockets was called");
  if (GetHasSkill(SKILL_PICK_POCKET,OBJECT_SELF)!=0)
  { // has skill
  //SendMessageToPC(GetFirstPC(),"[====PICK POCKETS====]");
  while(nLoop<10)
  { // while
   oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",
         OBJECT_SELF,nLoop,10.0);
   if (oTarget!=OBJECT_INVALID)
   { // !OI
    //SendMessageToPC(GetFirstPC(),"[==TEST:"+GetName(oTarget)+"==]");
    if ((GetIsPC(oTarget))||(!GetFactionEqual(oTarget)))
      nLoop=12;
   } // !OI
   if (nLoop!=12) nLoop++;
  } // while
  if (nLoop==12)
  { // Found a victim
    //SendMessageToPC(GetFirstPC(),"Victim found");
    //ActionSpeakString("My victim is "+GetName(oTarget));
    if(GetHasSkill(SKILL_HIDE,OBJECT_SELF))
     ActionUseSkill(SKILL_HIDE,OBJECT_SELF);
    ActionForceMoveToObject(oTarget,FALSE,0.5);
    ActionDoCommand(NPCACTPP(oTarget));
  } // Found a victim
 } // has skill
} // NPCActionPickPockets()

//-------------------------------------------------[ HEAL ]------------------
void NPCActionHealOthers()
{ // Heal other people
  int nLoop=1;
  object oHealee=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,5.0);
  while(oHealee!=OBJECT_INVALID)
  { // test others for need of healing
   if (GetMaxHitPoints(oHealee)>GetCurrentHitPoints(oHealee))
   { // healing needed
     ActionMoveToObject(oHealee,FALSE,0.5);
     effect eHeal=EffectHeal(GetMaxHitPoints(oHealee)-GetCurrentHitPoints(oHealee));
     ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,2.0);
     ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oHealee,1.5));
   } // healing needed
   nLoop++;
   oHealee=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,5.0);
  } // while
} // NPCActionHealOthers()

 //-------------------------------------------------
void NPCActionTaunt()
{ // look for someone not of your faction or a PC to taunt
 int nLoop=1;
 int nFound=FALSE;
 object oVictim;
 while(!nFound)
 { // look for a victim
   oVictim=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,5.0);
   nLoop++;
   if (oVictim!=OBJECT_INVALID)
   { // !OI
    if ((GetIsPC(oVictim))||(!GetFactionEqual(oVictim)&&GetLocalInt(OBJECT_SELF,"nGNBNN")==FALSE))
     nFound=TRUE;
   } // !OI
   else
    nFound=TRUE; // hit end of objects
 } // look for a victim
 if (oVictim!=OBJECT_INVALID)
 { // a victim was found
  ActionMoveToObject(oVictim,FALSE,0.8);
  ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT,1.0,2.0);
  if (GetHasSkill(SKILL_TAUNT))
   ActionUseSkill(SKILL_TAUNT,oVictim);
 } // a victim was found
} //NPCActionTaunt()

//---------------------------------------------------[ EAT ]----------------
void NPCActionEatNearbyFood()
{
  object oFood=GetNearestObjectMatch(OBJECT_TYPE_ITEM,
    "(NW_IT_MSMLMISC20|NW_IT_MMIDMISC05)",OBJECT_SELF,1,10.0);
  if (oFood!=OBJECT_INVALID)
  { // !OI
    ActionMoveToObject(oFood,FALSE,0.5);
    ActionPickUpItem(oFood);
    ActionDoCommand(DestroyObject(oFood));
  } // !OI
} // NPCActionEatNearbyFood()

//-------------------------------------------------[ RAND ]-----------------
void ACTRandomWalk()
{ // Random walk based on objects
  // Walks a random distance towards up to 6 random objects
  float fDist;
  float fRandDist;
  int nWork;
  int nRandom;
  object oDest;
  int nCycles=d6();  // up to 6 targets
  int nC=1;
 while (nC<=nCycles)
 { // loop
  nRandom=Random(40)+1;
  oDest=GetNearestObject(OBJECT_TYPE_ALL,OBJECT_SELF,nRandom);
  while(oDest==OBJECT_INVALID)
  { // find one
    nRandom=Random(40)+1;
    oDest=GetNearestObject(OBJECT_TYPE_ALL,OBJECT_SELF,nRandom);
  } // find one
  fDist=GetDistanceBetween(OBJECT_SELF,oDest);
  nWork=FloatToInt(fDist);
  nRandom=Random(nWork)+1;
  fRandDist=IntToFloat(nRandom);
  ActionMoveToObject(oDest,FALSE,fRandDist);
  nC++;
 } // loop
} // ACTRandomWalk()

//-------------------------------------------------[ BULL ]------------------
void NPCActionBully()
{ // Be a bully
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  effect eKnockdown;
  while(!nFound)
  { // while not found
    oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,8.0);
    nLoop++;
    if (oTarget!=OBJECT_INVALID)
    { // !OI
     if (GetHitDice(OBJECT_SELF)>=GetHitDice(oTarget))
      nFound=TRUE;
    } // !OI
    else
     nFound=TRUE; // end of objects
  } // while not found
  if (oTarget!=OBJECT_INVALID)
  { // act on target
    ActionMoveToObject(oTarget,TRUE,0.8);
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,3.0);
    eKnockdown=EffectKnockdown();
    AssignCommand(oTarget,ClearAllActions());
    DelayCommand(1.0,ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown,oTarget,3.0)));
  } // act on target
}// NPCActionBully()

//-------------------------------------------------[ PROP ]---------------------
void NPCActionProposition()
{
  string sProp="Why don't you come sit with me for awhile.";
  object oTarget;
  int nLoop=1;
  int nFound=FALSE;
  switch(Random(3))
  { // random statement
   case 0: sProp="Are you looking for a good time?";
    break;
   case 1: sProp="Would you like some company tonight?";
   default: break;
  } // random statement
  while(!nFound&&nLoop<10)
  { // look for client
   oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,15.0);
   nLoop++;
   if(oTarget!=OBJECT_INVALID)
   { // !OI
    if(GetGender(oTarget)!=GetGender(OBJECT_SELF))
     nFound=TRUE;
   } // !OI
   else
    nFound=TRUE; // end of objects
  } // look for client
  if (oTarget!=OBJECT_INVALID)
  { // client found
    ActionMoveToObject(oTarget,FALSE,0.8);
    SetFacingPoint(GetPosition(oTarget));
    ActionSpeakString(sProp);
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.0);
  } // client found
} // NPCActionProposition()

//-------------------------------------------------[ FOLLOW ]-----------------
void NPCActionFollow(int nParm)
{ // Follow a target
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // look for someone to follow
    oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,10.0);
    nLoop++;
    if (oTarget!=OBJECT_INVALID)
    { // !OI
      if((nParm==0)&&(GetGender(oTarget)==GENDER_FEMALE))
        nFound=TRUE;
      else if ((nParm==1)&&(GetGender(oTarget)==GENDER_MALE))
        nFound=TRUE;
      else if (nParm==2)
        nFound=TRUE;
      else if ((nParm==3)&&(GetIsPC(oTarget)))
        nFound=TRUE;
      else if ((nParm==4)&&(GetIsPC(oTarget))&&(GetGender(oTarget)==GENDER_FEMALE))
        nFound=TRUE;
      else if ((nParm==5)&&(GetIsPC(oTarget))&&(GetGender(oTarget)==GENDER_MALE))
        nFound=TRUE;
    } // !OI
    else
      nFound=TRUE; // end of objects
  } // look for someone to follow
  if (oTarget!=OBJECT_INVALID)
  { // follow them
   ActionMoveToObject(oTarget,FALSE,1.5);
   ActionForceFollowObject(oTarget,1.5);
  } // follow them
} // NPCActionFollow()

//-------------------------------------------------[ WORSHIP ]--------------
void NPCActionWorship(int nParm)
{
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // look for target
   oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,8.0);
   nLoop++;
   if (oTarget!=OBJECT_INVALID)
   { // !OI
     if((nParm==0)&&(GetIsPC(oTarget)))
       nFound=TRUE;
     if((nParm==1)&&(!GetIsPC(oTarget)))
       nFound=TRUE;
   } // !OI
   else
    nFound=TRUE;
  } // look for target
  if (oTarget!=OBJECT_INVALID)
  { // worship them
    NADisable();
    ActionMoveToObject(oTarget,TRUE,1.8);
    ActionDoCommand(SetFacingPoint(GetPosition(oTarget)));
    ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,7.0);
    ActionDoCommand(NAEnable());
    DelayCommand(20.0,NAEnable()); // this delay command makes sure not stuck
  } // worship them
} // NPCActionWorship()


void NPCActSing(float fDelay,string sLyric)
{ // Support for the singing function coming
  int nRnd=d4();
  ActionWait(fDelay);
  if (nRnd==1) ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0,2.0);
  else if (nRnd==2) ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2,1.0,2.0);
  else if (nRnd==3) ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3,1.0,2.0);
  else if (nRnd==4) ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING,1.0,2.0);
  ActionSpeakString(sLyric);
} // NPCActSing()


//-------------------------------------------------[ SING ]---------------
void NPCActionSing(int nParm)
{ // Songs by Deva Bryson Winblood (quickly written)
 switch(nParm)
 { // song switch
   case 0: { // My Lass and her very fine ass
    ActionSpeakString("One bright and kindly summers morning...");
    NPCActSing(4.0,"I perchance passed the field of my toils");
    NPCActSing(5.0,"There I saw my hearts definate warning...");
    NPCActSing(5.0,"I happened to see my woman's donkey");
    NPCActSing(6.0,"Sing with me: My lass has a very fine ass");
    NPCActSing(4.0,"Don't you know it works all day");
    NPCActSing(4.0,"My lass has a very fine ass");
    NPCActSing(4.0,"It works and doesn't get pay");
    NPCActSing(5.0,"So next time you're at the market.");
    NPCActSing(5.0,"Make sure its a donkey you buy");
    NPCActSing(5.0,"For prideful they may be");
    NPCActSing(5.0,"But, to work their pay is just right");
    NPCActSing(6.0,"My lass has a very fine ass");
    NPCActSing(4.0,"Don't you know it works all day");
    NPCActSing(4.0,"My lass has a very fine ass");
    NPCActSing(4.0,"It works and doesn't get pay");
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    break;
   } // My lass
   case 1: { // Drink them under the table
    ActionSpeakString("Raise your cup high and proud: Sing with me.");
    NPCActSing(5.0,"Stomp your feet, shake the ground.");
    NPCActSing(5.0,"Greet your chums round 'bout.");
    NPCActSing(5.0,"Show them what drinkings all 'bout.");
    NPCActSing(5.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"SLAM THAT ALE DOWN AND DOWN");
    NPCActSing(4.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"WATCH THEIR PRIDE FALLIN' DOWN");
    NPCActSing(5.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"SLAM THAT ALE DOWN AND DOWN");
    NPCActSing(4.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"WATCH THEIR PRIDE FALLIN' DOWN");
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    break;
   } // Drink them under the table
   case 2: { // The labors of the sea
    ActionSpeakString("The sea is my larder...");
    NPCActSing(5.0,"It is where the fish grow.");
    NPCActSing(5.0,"The sea provides my staples...");
    NPCActSing(5.0,"As you all surely know.");
    NPCActSing(5.0,"The sea provides shelter...");
    NPCActSing(5.0,"to the wise man they will show.");
    NPCActSing(5.0,"The sea is as stable...");
    NPCActSing(5.0,"as the time honored know.");
    NPCActSing(5.0,"The sea is my roadway...");
    NPCActSing(5.0,"Whereever the winds blow.");
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    break;
   } // The labors of the sea
   case 3: { // Unrequited Love
    ActionSpeakString("[SINGING] Why are your eyes so blue all the time...");
    NPCActSing(8.0,"Why are your eyes always looking into mine...");
    NPCActSing(8.0,"Where did you come from, and where will you go...");
    NPCActSing(8.0,"Find my hand and take me where you go...");
    NPCActSing(8.0,"If I love you, will you love me too");
    NPCActSing(8.0,"Will you be there, whenever I need you.");
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    break;
   } // Unrequited Love
   case 4: { // Rape and pillage
    ActionSpeakString("[SINGING] See them run, see them crawl.");
    NPCActSing(4.0,"That's what makes it worth it all.");
    NPCActSing(4.0,"Hear them scream, hear them weep.");
    NPCActSing(4.0,"That's what helps me sleep a wink.");
    NPCActSing(4.0,"Rape and Pillage");
    NPCActSing(3.0,"Burn the village");
    NPCActSing(3.0,"Rape and Pillage");
    NPCActSing(3.0,"Rape and Pillage");
    NPCActSing(5.0,"We don't need the pay");
    NPCActSing(4.0,"We just need some prey");
    NPCActSing(4.0,"We don't need friends");
    NPCActSing(4.0,"We prefer bone snapping trends");
    NPCActSing(4.0,"Rape and Pillage");
    NPCActSing(3.0,"Burn the village");
    NPCActSing(3.0,"Rape and pillage");
    NPCActSing(3.0,"RAPE AND PILLAGE!!");
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    break;
   } // Rape and pillage
   case 5: { // epic tale of heroism
    ActionSpeakString("[SINGING] T'wards the mountains went the bodies...");
    NPCActSing(4.0,"of those the monster had taken.");
    NPCActSing(4.0,"T'wards the caverns went the fighters.");
    NPCActSing(4.0,"Never seen or heard again.");
    NPCActSing(4.0,"The fear was gripping hearts");
    NPCActSing(4.0,"The pride had fallen low");
    NPCActSing(4.0,"Then came the hero.");
    NPCActSing(4.0,"The one that was unknown.");
    NPCActSing(4.0,"T'wards the mountains he wandered");
    NPCActSing(4.0,"N'er turning to look back.");
    NPCActSing(4.0,"T'wards the caverns he stumbled");
    NPCActSing(4.0,"N'er considering what was there");
    NPCActSing(4.0,"And there he did battle");
    NPCActSing(4.0,"And there he did fall");
    NPCActSing(4.0,"Lo' a woman did return");
    NPCActSing(4.0,"Hail! she escaped it all");
    NPCActSing(4.0,"Hark! it did end.");
    NPCActSing(4.0,"The fear was no more");
    NPCActSing(4.0,"Heads lifted in pride once more.");
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    break;
   } // epic tale of heroism
   case 6: { // Rhyming Dance tune
    ActionSpeakString("[SINGING] Find the barrel");
    NPCActSing(3.0,"Bolt and Arrow");
    NPCActSing(3.0,"Grow the crops");
    NPCActSing(3.0,"Tend your shops");
    NPCActSing(3.0,"Sail the ships");
    NPCActSing(3.0,"Sway your hips");
    NPCActSing(3.0,"Kiss the Lass");
    NPCActSing(3.0,"Swat her arse");
    NPCActSing(3.0,"Grab a Potion");
    NPCActSing(3.0,"Forbidden Lotion");
    NPCActSing(3.0,"Swim the River");
    NPCActSing(3.0,"Love your giver");
    NPCActSing(3.0,"Taste the ale");
    NPCActSing(3.0,"Drain it well");
    NPCActSing(3.0,"Close the bin");
    NPCActSing(3.0,"Let's sing again");
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    break;
   } // Rhyming Commoner Dance Tune
   default: break;
 } // song switch
}// NPCActionSing()

//---------------------------------------------------------[ ATTK ]-------
void NPCActionAttackPlaceable()
{
  object oTarget=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,"**",OBJECT_SELF,1,5.0);
  float fDist;
  if (oTarget!=OBJECT_INVALID)
  { // !OI
    fDist=GetDistanceBetween(oTarget,OBJECT_SELF);
    if (fDist>1.2)
      ActionMoveToObject(oTarget,FALSE,1.2);
    ActionAttack(oTarget,TRUE);
  } // !OI
} // NPCActionAttackPlaceable()

//-------------------------------------------------[LTON/LTOF]----------------
void NPCActionLights(int nParm)
{
  int nLoop=1;
  int nOnOff=0;
  int nFlag=FALSE;
  object oArea=GetArea(OBJECT_SELF);
  object oLight=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
   "(LampPost|Brazier|Campfire|CampfireCauldron|CampfirewithSpit|PillarStyle1|Candelabra)",
   OBJECT_SELF,nLoop,5.0);
  while(oLight!=OBJECT_INVALID)
  { // !OI
   if (nParm==0) {nOnOff=1; nFlag=TRUE;}
     ActionMoveToObject(oLight,FALSE,0.5);
     SetLocalInt(OBJECT_SELF,"nOffOn",nOnOff);
     ActionInteractObject(oLight);
     SetPlaceableIllumination(oLight, nFlag);
   nLoop++;
   oLight=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
   "(LampPost|Brazier|Campfire|CampfireCauldron|CampfirewithSpit|PillarStyle1|Candelabra)",
   OBJECT_SELF,nLoop,5.0);
  } // !OI
  RecomputeStaticLighting(oArea);
} // NPCActionLights()

//-------------------------------------------------[ MAG1,2,3 ]------------
void NPCActionMagicEffect(int nParm)
{
  effect eMEffect; // effect
  switch(nParm)
  { // switch
    case 0:eMEffect=EffectVisualEffect(VFX_IMP_LIGHTNING_M);
     break;
    case 1:eMEffect=EffectVisualEffect(VFX_IMP_HEAD_FIRE);
     break;
    default:eMEffect=EffectVisualEffect(VFX_IMP_HOLY_AID);
     break;
  } // switch
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMEffect,OBJECT_SELF,5.0);
} // NPCActionMagicEffect()

//-------------------------------------------------[ KILL ]-----------------
void NPCActionAttackNearby()
{
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // looking
    oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,12.0);
    nLoop++;
    if (oTarget!=OBJECT_INVALID)
    { // !OI
     if ((GetIsPC(oTarget))||(!GetFactionEqual(oTarget)))
      nFound=TRUE;
    } // !OI
    else
     nFound=TRUE; // Done looking
  } // looking
  if (oTarget!=OBJECT_INVALID)
  { // Attack the target
    ActionMoveToObject(oTarget,TRUE,1.0);
    ActionAttack(oTarget,FALSE);
    SetIsTemporaryEnemy(oTarget,OBJECT_SELF);
    SetIsTemporaryEnemy(OBJECT_SELF,oTarget);
  } // Attack the target
} // NPCActionAttackNearby()

int fnCheckIsUndead(object oTarget)
{ // Test to see if undead
  int nRet=FALSE;
  if (GetClassByPosition(1,oTarget)==CLASS_TYPE_UNDEAD) nRet=TRUE;
  else if (GetClassByPosition(2,oTarget)==CLASS_TYPE_UNDEAD) nRet=TRUE;
  else if (GetClassByPosition(3,oTarget)==CLASS_TYPE_UNDEAD) nRet=TRUE;
  return nRet;
} //fnCheckIsUndead()

//-------------------------------------------------[ TURN ]------------------
void NPCActionTurnUndead()
{
  int nLoop=1;
  object oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,10.0);
  if (GetHasFeat(FEAT_TURN_UNDEAD,OBJECT_SELF))
  {// has turn undead
  while(oTarget!=OBJECT_INVALID)
  { //!OI
    if(fnCheckIsUndead(oTarget))
    { // It is an undead
      ActionMoveToObject(oTarget,TRUE,2.0);
      ActionUseFeat(FEAT_TURN_UNDEAD,oTarget);
      SetIsTemporaryEnemy(oTarget,OBJECT_SELF);
      SetIsTemporaryEnemy(OBJECT_SELF,oTarget);
    } // It is an undead
    nLoop++;
    oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,10.0);
  } //!OI
  }// has turn undead
} // NPCActionTurnUndead()

//-------------------------------------------------[ HELT ]-----------------
void NPCActionHealSelf()
{
  if (GetMaxHitPoints(OBJECT_SELF)>GetCurrentHitPoints(OBJECT_SELF))
  {
    effect eHeal=EffectHeal(GetMaxHitPoints(OBJECT_SELF)-GetCurrentHitPoints(OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF,1.0);
  }
} //NPCActionHealSelf()

//---------------------------------------------------[ STTR ]---------------
void NPCActionSetTrap()
{
  if (GetHasSkill(SKILL_SET_TRAP)==TRUE)
  { // has set trap skill
  object oItem=GetItemPossessedBy(OBJECT_SELF,"NW_IT_TRAP035");
  object oWhere=GetNearestObjectByTag("NPC_TRAP_POINT");
  int nCount=35;
  location lTrap=GetLocation(oWhere);
  string sTrapTag;
  object oArea=GetArea(OBJECT_SELF);
  object oNewTrap;
  int nWorkVar;
  int nRadius;
  int nDetectDC;
  int nDisarmDC;
  int nSingleFire;
  string sScript;
  string sWork;
  // <radius>.<detect>.<disarm>.<single>.<script>
  string sName; // name for NPC_TRAP_POINT
  while(nCount>1&&oItem==OBJECT_INVALID)
  { // check to see if possess trap
    nCount--;
    sTrapTag="NW_IT_TRAP0";
    if (nCount>9) sTrapTag=sTrapTag+IntToString(nCount);
    else sTrapTag=sTrapTag+"0"+IntToString(nCount);
    oItem=GetItemPossessedBy(OBJECT_SELF,sTrapTag);
  } // check to see if possess trap
  if(oItem==OBJECT_INVALID)
  { // fine then search for custom traps
    if (NPCACT_CUSTOMTRAPS>0)
    { // there are custom traps
      nCount=1;
      sTrapTag="NPCACT_TRAP_1";
      oItem=GetItemPossessedBy(OBJECT_SELF,sTrapTag);
      while(oItem==OBJECT_INVALID&&nCount<NPCACT_CUSTOMTRAPS)
      { // poll inventory
        nCount++;
        sTrapTag="NPCACT_TRAP_"+IntToString(nCount);
        oItem=GetItemPossessedBy(OBJECT_SELF,sTrapTag);
      } // poll inventory
    } // there are custom traps
  } // fine then search for custom traps
  if (oItem!=OBJECT_INVALID&&oWhere!=OBJECT_INVALID)
  { // !OI
    ActionForceMoveToObject(oWhere,FALSE,0.5);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,4.0);
    ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,OBJECT_SELF));
    oNewTrap=CreateObject(OBJECT_TYPE_PLACEABLE,"npcact_trap_invis",lTrap,FALSE);
    if (oNewTrap==OBJECT_INVALID)
    { // did not work
      ActionSpeakString("Humphhhh... my trap did not work");
    } // did not work
    else
    { // trap set
      nWorkVar=GetLocalInt(oArea,"nNPCACTTraps");
      nWorkVar++;
      SetLocalInt(oArea,"nNPCACTTraps",nWorkVar);
      sName=GetName(oWhere);
      while(GetStringLeft(sName,1)!="."&&GetStringLength(sName)>0)
      { // build radius
        sWork=sWork+GetStringLeft(sName,1);
        sName=GetStringRight(sName,GetStringLength(sName)-1);
      } // build radius
      if (GetStringLeft(sName,1)==".") sName=GetStringRight(sName,GetStringLength(sName)-1);
      nRadius=StringToInt(sWork);
      sWork="";
       while(GetStringLeft(sName,1)!="."&&GetStringLength(sName)>0)
      { // detect DC
        sWork=sWork+GetStringLeft(sName,1);
        sName=GetStringRight(sName,GetStringLength(sName)-1);
      } // detect DC
      if (GetStringLeft(sName,1)==".") sName=GetStringRight(sName,GetStringLength(sName)-1);
      nDetectDC=StringToInt(sWork);
      sWork="";
       while(GetStringLeft(sName,1)!="."&&GetStringLength(sName)>0)
      { // Disarm DC
        sWork=sWork+GetStringLeft(sName,1);
        sName=GetStringRight(sName,GetStringLength(sName)-1);
      } // Disarm DC
      if (GetStringLeft(sName,1)==".") sName=GetStringRight(sName,GetStringLength(sName)-1);
      nDisarmDC=StringToInt(sWork);
      while(GetStringLeft(sName,1)!="."&&GetStringLength(sName)>0)
      { // single usage
        sWork=sWork+GetStringLeft(sName,1);
        sName=GetStringRight(sName,GetStringLength(sName)-1);
      } // single usage
      if (GetStringLeft(sName,1)==".") sName=GetStringRight(sName,GetStringLength(sName)-1);
      nSingleFire=StringToInt(sWork);
      sScript=sName;
      SetLocalInt(oNewTrap,"nRadius",nRadius);
      SetLocalInt(oNewTrap,"nDetect",nDetectDC);
      SetLocalInt(oNewTrap,"nDisarm",nDisarmDC);
      SetLocalInt(oNewTrap,"nSingleFire",nSingleFire);
      if(sScript!="DEFAULT")
       {
        SetLocalString(oNewTrap,"sScript",sScript);
       }
      else
      { // default script
        sWork=GetTag(oItem);
        if (GetStringLength(sWork)>9) sWork=GetStringRight(sWork,9);
        sScript="DOTRAP_"+sWork;
        SetLocalString(oNewTrap,"sScript",sScript);
      } // default script
      DestroyObject(oItem);
    } // trap set
   } // !OI
 } // has set trap skill
}// NPCActionSetTrap()

//---------------------------------------------------[ RMTR ]----------------
void NPCActionRemoveTrap()
{
  if (GetHasSkill(SKILL_DISABLE_TRAP,OBJECT_SELF)==TRUE)
  { // has the skill
    object oTrap =GetNearestObjectByTag("npcact_trap_invis",OBJECT_SELF,1);
    if (oTrap!=OBJECT_INVALID)
    { // !OI
      int nDisarm=GetLocalInt(oTrap,"nDisarm");
      int nRadius=GetLocalInt(oTrap,"nRadius");
      float fDist=GetDistanceBetween(OBJECT_SELF,oTrap);
      int nDist=FloatToInt(fDist);
      if (nDist<nRadius*2&&nDist>nRadius)
      { // try to disarm it
        fDist=IntToFloat(nDist-nRadius);
        fDist=fDist+1.0;
        ActionMoveToObject(oTrap,FALSE,fDist);
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,5.0);
        int nWork=d20()+GetSkillRank(SKILL_DISABLE_TRAP,OBJECT_SELF);
        if (nWork>=nDisarm)
        { // disarmed
         nWork=GetLocalInt(GetArea(oTrap),"nNPCACTTraps");
         nWork--;
         SetLocalInt(GetArea(oTrap),"nNPCACTTraps",nWork);
         DestroyObject(oTrap);
         ActionSpeakString("That trap is disabled.");
        } // disarmed
        else if (nWork<nDisarm-10)
        { // failed set it off
          ActionSpeakString("That wasn't right.");
          ExecuteScript(GetLocalString(oTrap,"sScript"),oTrap);
        } // failed set it off
        else
        { // didn't disarm
          ActionSpeakString("This trap is tough.  I haven't gotten rid of it.");
        } // didn't disarm
      } // try to disarm it
    } // !OI
  } // has the skill
}// NPCActionRemoveTrap()

void NPCACTPKLK(object oLock)
{
  if (!GetLocked(oLock))
   AssignCommand(oLock,ActionSpeakString("*click*"));
} // NPCACTPKLK support function

//------------------------------------------------------[ PKLK ]------------
void NPCActionPickLock()
{
  if(GetHasSkill(SKILL_OPEN_LOCK,OBJECT_SELF)==TRUE)
  { // has the skill
    int nLoop=1;
    object oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,6.0);
    while (oDoor!=OBJECT_INVALID&&nLoop<5&&!GetLocked(oDoor))
    { // look for door
      nLoop++;
      oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,6.0);
    } // look for door
    if (oDoor==OBJECT_INVALID)
    { // look for container
      nLoop=1;
      oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,6.0);
      while(oDoor!=OBJECT_INVALID&&nLoop<5&&!GetLocked(oDoor))
      { // check containers
        nLoop++;
        oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,6.0);
      } // check containers
    } // look for container
    if (oDoor!=OBJECT_INVALID&&GetLocked(oDoor))
    { // this is the one
      ActionMoveToObject(oDoor,FALSE,1.0);
      ActionUseSkill(SKILL_OPEN_LOCK,oDoor);
      DelayCommand(5.0,AssignCommand(OBJECT_SELF,NPCACTPKLK(oDoor)));
    } // this is the one
  } // has the skill
}// NPCActionPickLock()

//---------------------------------------------------[ KNOC ]--------------
void NPCActionKnockSpell()
{
  if(GetHasSpell(SPELL_KNOCK,OBJECT_SELF)!=0)
  { // has the SPELL
    int nLoop=1;
    object oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,10.0);
    while (oDoor!=OBJECT_INVALID&&nLoop<5&&!GetLocked(oDoor))
    { // look for door
      nLoop++;
      oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,10.0);
    } // look for door
    if (oDoor==OBJECT_INVALID)
    { // look for container
      nLoop=1;
      oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,10.0);
      while(oDoor!=OBJECT_INVALID&&nLoop<5&&!GetLocked(oDoor))
      { // check containers
        nLoop++;
        oDoor=GetNearestObjectMatch(OBJECT_TYPE_DOOR,"**",OBJECT_SELF,nLoop,10.0);
      } // check containers
    } // look for container
    if (oDoor!=OBJECT_INVALID&&GetLocked(oDoor))
    { // this is the one
      ActionMoveToObject(oDoor,FALSE,1.0);
      ActionCastSpellAtObject(SPELL_KNOCK,oDoor,METAMAGIC_ANY,TRUE);
      AssignCommand(oDoor,SetLocked(oDoor,FALSE));
      DelayCommand(5.0,AssignCommand(OBJECT_SELF,NPCACTPKLK(oDoor)));
    } // this is the one
  } // has the SPELL
}// NPCActionKnockSpell()

//--------------------------------------------------[ WAKE ]-----------------
void NPCActionWakeupSleeper()
{
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // Find target
   oTarget=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,10.0);
   GNBErrorReport("Wakeupcheck:"+GetName(oTarget));
   if (oTarget!=OBJECT_INVALID)
   { // !OI
    if (GetLocalInt(oTarget,"nGNBSleeping")==TRUE)
     nFound=TRUE; // this is the one
   } // !OI
   nLoop++;
   if(nLoop>5||oTarget==OBJECT_INVALID) nFound=TRUE; // exit loop
  } // Find Target
  if (oTarget!=OBJECT_INVALID)
  { // wake
    ActionMoveToObject(oTarget,FALSE,0.5);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0);
    ActionSpeakString("Awaken you.");
    AssignCommand(oTarget,ClearAllActions());
    DelayCommand(2.0,GNBRemoveEffect(EFFECT_TYPE_SLEEP, oTarget));
    SetLocalInt(oTarget,"nGNBMaxHB",0);
    SetLocalInt(oTarget,"nGNBSleeping",FALSE);
  } // wake
}// NPCWakeUpSleeper()

//--------------------------------------------------[ CAMP ]-----------------
void NPCActionMakeCampfire()
{
 object oFire=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,"(Campfire)",OBJECT_SELF,1,2.0);
 if (oFire==OBJECT_INVALID)
 {
  location lHere=GetLocation(OBJECT_SELF);
  ActionMoveAwayFromLocation(lHere,FALSE,0.8);
  oFire=CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfr",lHere,TRUE);
 }
}// NPCActionMakeCampfire()

//-------------------------------------------------[ V### ]-----------------
void NPCActionSetVar(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nSetTo=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  SetLocalInt(OBJECT_SELF,sName,nSetTo);
}// NPCActionSetVar()

//-------------------------------------------------[ SAY# ]-----------------
void NPCActionSayPhrase(string sParm)
{
  int nPhrase=StringToInt(GetStringRight(sParm,1));
  string sName="sSayString"+IntToString(nPhrase);
  string sToSay=GetLocalString(OBJECT_SELF,sName);
  if (GetStringLength(sToSay)<1)
  { // look for way points with the phrase
   sName="VAR_"+GetTag(OBJECT_SELF)+"_"+IntToString(nPhrase);
   object oWP=GetObjectByTag(sName);
   if (oWP!=OBJECT_INVALID)
   { // !OI
    sToSay=GetName(oWP);
   } // !OI
  } // look for way points with the phrase
  ActionSpeakString(sToSay);
}// NPCActionSayPhrase()

//-------------------------------------------------[ COP# ]-----------------
void NPCActionCopyVar(string sParm)
{
  int nVarNum=StringToInt(GetStringRight(sParm,1));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  int nLoop=1;
  int nValue=GetLocalInt(OBJECT_SELF,sName);
  int nCopy=0;
  object oPerson=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,5.0);
  while(oPerson!=OBJECT_INVALID)
  { // !OI
   if(GetLocalInt(oPerson,sName)>nCopy) nCopy=GetLocalInt(oPerson,sName);
   nLoop++;
   oPerson=GetNearestObjectMatch(OBJECT_TYPE_CREATURE,"**",OBJECT_SELF,nLoop,5.0);
  } // !OI
  if (nCopy>nValue)
   SetLocalInt(OBJECT_SELF,sName,nCopy);
}// NPCActionCopyVar()

//-----------------------------------------------------[ I### ]-------------
void NPCActionIfStatement(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nValue=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  if (GetLocalInt(OBJECT_SELF,sName)!=nValue)
  {
    SetLocalInt(OBJECT_SELF,"nDoAnotherCommand",FALSE);
    SetLocalString(OBJECT_SELF,"sGNBActions","");
  }
}// NPCActionIfStatement()

//--------------------------------------------------[ A### ]-----------------
void NPCActionAddTo(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nValue=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  SetLocalInt(OBJECT_SELF,sName,GetLocalInt(OBJECT_SELF,sName)+nValue);
}//NPCActionAddTo()

//-------------------------------------------------[ S### ]------------------
void NPCActionSubtractFrom(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nValue=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  int nCurrent=GetLocalInt(OBJECT_SELF,sName);
  nCurrent=nCurrent-nValue;
  if (nCurrent<0) nCurrent=0;
  SetLocalInt(OBJECT_SELF,sName,nCurrent);
}// NPCActionSubtractFrom()

//-------------------------------------------------[ CLO# ]------------------
void NPCActionChangeClothes(string sParm)
{
  string sClothVar="sNPCActCloth"+GetStringRight(sParm,1);
  string sClothResRef=GetLocalString(OBJECT_SELF,sClothVar);
  if (GetStringLength(sClothResRef)>2)
  { // we have clothing
    object oClothing=GetItemInSlot(INVENTORY_SLOT_CHEST); // currently wearing
    //SendMessageToPC(GetFirstPC(),"WEARING:"+GetTag(oClothing));
    if (sClothResRef!="NONE")
    { // create new clothing
     object oNewCloth=CreateItemOnObject(sClothResRef);
     if (oNewCloth!=OBJECT_INVALID)
     { //!OI
       ActionEquipItem(oNewCloth,INVENTORY_SLOT_CHEST);
       //SendMessageToPC(GetFirstPC(),"CHANGED:"+GetTag(oNewCloth));
       ActionDoCommand(DestroyObject(oClothing)); // destroy old clothing
     } //!OI
    } // create new clothing
    else if (sClothResRef=="NONE")
      ActionDoCommand(DestroyObject(oClothing)); // destroy old clothing
  } // we have clothing
}// NPCActionChangeClothes()

//-------------------------------------------------[ SUM# ]------------------
void NPCActionSummonCreature(string sParm)
{
  string sSC=GetStringRight(sParm,1);
  string sMonResRef="";
  if (sSC=="0")
  { // 0 level
    switch (d4())
    { // 0 level
      case 1: sMonResRef="nw_badger"; break;
      case 2: sMonResRef="nw_bat"; break;
      case 3: sMonResRef="nw_btlfire"; break;
      case 4: sMonResRef="nw_goblina"; break;
    } // 0 level
  } // 0 level
  else if (sSC=="1")
  { // 1 Level
    switch (d4())
    { // Level 1
      case 1: sMonResRef="nw_dog"; break;
      case 2: sMonResRef="nw_nixie"; break;
      case 3: sMonResRef="nw_wolf"; break;
      case 4: sMonResRef="nw_dog"; break;
    } // Level 1
  } // 1 Level
  else if (sSC=="2")
  { // 2 Level
    switch(d4())
    { // Level 2
      case 1: sMonResRef="nw_pixie"; break;
      case 2: sMonResRef="nw_bearblck"; break;
      case 3: sMonResRef="nw_mepdust"; break;
      case 4: sMonResRef="nw_btlfire02"; break;
    } // Level 2
  } // 2 Level
  else if (sSC=="3")
  { // 3 Level
    switch(d4())
    { // Level 3
      case 1: sMonResRef="nw_nymph"; break;
      case 2: sMonResRef="nw_imp"; break;
      case 3: sMonResRef="nw_worg"; break;
      case 4: sMonResRef="nw_spidgiant"; break;
    } // Level 3
  } // 3 Level
  else if (sSC=="4")
  { // 4 Level
    switch(d4())
    { // Level 4
      case 1: sMonResRef="nw_lion"; break;
      case 2: sMonResRef="nw_fenhound"; break;
      case 3: sMonResRef="nw_ettercap"; break;
      case 4: sMonResRef="nw_minotaur"; break;
    } // Level 4
  } // 4 Level
  else if (sSC=="5")
  { // 5 Level
    switch(d4())
    { // Level 5
      case 1: sMonResRef="nw_bearbrwn"; break;
      case 2: sMonResRef="nw_direwolf"; break;
      case 3: sMonResRef="nw_boardire"; break;
      case 4: sMonResRef="nw_troll"; break;
    } // Level 5
  } // 5 Level
  else if (sSC=="6")
  { // 6 Level
    switch(d6())
    { // Level 6
      case 1: sMonResRef="nw_air"; break;
      case 2: sMonResRef="nw_earth"; break;
      case 3: sMonResRef="nw_fire"; break;
      case 4: sMonResRef="nw_water"; break;
      case 5: sMonResRef="nw_bearkodiak"; break;
      case 6: sMonResRef="nw_wolfwint"; break;
    } // Level 6
  } // 6 Level
  else if (sSC=="7")
  { // 7 Level
    switch(d4())
    { // Level 7
      case 1: sMonResRef="nw_umberhulk"; break;
      case 2: sMonResRef="nw_devour"; break;
      case 3: sMonResRef="nw_slaadbl"; break;
      case 4: sMonResRef="nw_shadow"; break;
    } // Level 7
  } // 7 Level
  else if (sSC=="8")
  { // 8 Level
    switch(d4())
    { // Level 8
      case 1: sMonResRef="nw_chound01"; break;
      case 2: sMonResRef="nw_allip"; break;
      case 3: sMonResRef="nw_grayrend"; break;
      case 4: sMonResRef="nw_minchief"; break;
    } // Level 8
  } // 8 Level
  else if (sSC=="9")
  { // 9 Level
    switch(d4())
    { // Level 9
      case 1: sMonResRef="nw_dmsucubus"; break;
      case 2: sMonResRef="nw_slaadgrn"; break;
      case 3: sMonResRef="nw_beardire"; break;
      case 4: sMonResRef="nw_minwiz"; break;
    } // Level 9
  } // 9 Level
  if (GetStringLength(sMonResRef)>4)
  { // conjure
    effect eSummon=EffectSummonCreature(sMonResRef,VFX_FNF_SUMMON_MONSTER_1,2.0);
    vector vSummon;
    location lSelf=GetLocation(OBJECT_SELF);
    vSummon=GetPosition(OBJECT_SELF);
    vSummon.x=vSummon.x+1.0;
    vSummon.y=vSummon.y+1.0;
    location lSummon=Location(GetArea(OBJECT_SELF),vSummon,GetFacing(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eSummon,lSummon,2.0);
    object oCreature=CreateObject(OBJECT_TYPE_CREATURE,sMonResRef,lSummon,TRUE);
    ChangeFaction(oCreature,OBJECT_SELF);
  } // conjure
}// NPCActionSummonCreature()

//-------------------------------------------------[ ! ]--------------------
void NPCAct3Set(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sSetTo="";
   string sWork=sIn;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip !
   sVarType=GetStringLeft(sWork,1);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip var type
   while(GetStringLeft(sWork,1)!="/"&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)=="/"&&GetStringLength(sWork)>1)
   { // strip / and build sSetTo
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
     while(GetStringLength(sWork)!=0)
     { // build set
       sSetTo=sSetTo+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
     } // build set
     if (sVarType=="I")
       SetLocalInt(OBJECT_SELF,sVarName,StringToInt(sSetTo));
     else if (sVarType=="S")
       SetLocalString(OBJECT_SELF,sVarName,sSetTo);
     else if (sVarType=="R")
     {
       int nRV=Random(StringToInt(sSetTo))+1;
       SetLocalInt(OBJECT_SELF,sVarName,nRV);
     }
     else if (sVarType=="i")
     { // i
       SetLocalInt(OBJECT_SELF,sVarName,GetLocalInt(OBJECT_SELF,sSetTo));
     } // i
     else if (sVarType=="s")
     { // s
       SetLocalString(OBJECT_SELF,sVarName,GetLocalString(OBJECT_SELF,sSetTo));
     } // s
     else if (sVarType=="H")
     { // H
       SetLocalInt(OBJECT_SELF,sVarName,GetTimeHour());
     } // H
   } // strip / and build sSetTo
   if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+":SET:"+sVarType+"("+sVarName+","+sSetTo+")");
}// NPCAct3Set()

//-------------------------------------------------------[ + ]--------------
void NPCAct3Add(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sAdd="";
   string sWork=sIn;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip +
   sVarType=GetStringLeft(sWork,1);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip var type
   while(GetStringLeft(sWork,1)!="/"&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)=="/"&&GetStringLength(sWork)>1)
   { // strip / and build sSetTo
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
     while(GetStringLength(sWork)!=0)
     { // build set
       sAdd=sAdd+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
     } // build set
     if (sVarType=="I")
     {
       if (DEEP_DEBUG_ON) GNBErrorReport("INTEGER:"+IntToString(GetLocalInt(OBJECT_SELF,sVarName)+StringToInt(sAdd)));
       SetLocalInt(OBJECT_SELF,sVarName,GetLocalInt(OBJECT_SELF,sVarName)+StringToInt(sAdd));
     }
     else if (sVarType=="S")
       SetLocalString(OBJECT_SELF,sVarName,GetLocalString(OBJECT_SELF,sVarName)+sAdd);
   } // strip / and build sSetTo
   if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+":AD:"+sVarType+"("+sVarName+","+sAdd+")");
}// NPCAct3Add()

//------------------------------------------------------[ - ]----------------
void NPCAct3Sub(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sAdd="";
   string sWork=sIn;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip -
   sVarType=GetStringLeft(sWork,1);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip var type
   while(GetStringLeft(sWork,1)!="/"&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)=="/"&&GetStringLength(sWork)>1)
   { // strip / and build sSetTo
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
     while(GetStringLength(sWork)!=0)
     { // build set
       sAdd=sAdd+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
     } // build set
     if (sVarType=="I")
       SetLocalInt(OBJECT_SELF,sVarName,GetLocalInt(OBJECT_SELF,sVarName)-StringToInt(sAdd));
   } // strip / and build sSetTo
   if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+":SUB:"+sVarType+"("+sVarName+","+sAdd+")");
}// NPCAct3Sub()

//-----------------------------------------------------[ & ]----------------
void NPCAct3If(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sAdd="";
   string sWork=sIn;
   int nWork1;
   int nWork2;
   int nWork3;
   int nWork4;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip &
   sVarType=GetStringLeft(sWork,2);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-2); // strip var type
   while(GetStringLeft(sWork,1)!="/"&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)=="/")
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
   while(GetStringLength(sWork)!=0)
   { // build set
       sAdd=sAdd+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build set
     int nDoAbortActs=TRUE;
     if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" IF:"+sVarType+",'"+sVarName+"',"+sAdd+"  sWork="+sWork);
     if (sVarType=="IE")
     { // IE
       if (GetLocalInt(OBJECT_SELF,sVarName)==StringToInt(sAdd))
         nDoAbortActs=FALSE;
     } // IE
     else if (sVarType=="IG")
     { // IG
       if (GetLocalInt(OBJECT_SELF,sVarName)>StringToInt(sAdd))
       {
        if (DEEP_DEBUG_ON) GNBErrorReport("  Condition is TRUE");
         nDoAbortActs=FALSE;
       }
       if (DEEP_DEBUG_ON) GNBErrorReport("  VALUES:"+IntToString(GetLocalInt(OBJECT_SELF,sVarName))+" sAdd:"+sAdd);
     } // IG
     else if (sVarType=="IL")
     { // IL
        if (GetLocalInt(OBJECT_SELF,sVarName)<StringToInt(sAdd))
          nDoAbortActs=FALSE;
     } // IL
     else if (sVarType=="IN")
     { // IN
        if (GetLocalInt(OBJECT_SELF,sVarName)!=StringToInt(sAdd))
          nDoAbortActs=FALSE;
     } // IN
     else if (sVarType=="SE")
     { // SE
        if (GetLocalString(OBJECT_SELF,sVarName)==sAdd)
          nDoAbortActs=FALSE;
     } // SE
     else if (sVarType=="SN")
     { // SN
        if (GetLocalString(OBJECT_SELF,sVarName)!=sAdd)
          nDoAbortActs=FALSE;
     } // SN
     else if (sVarType=="HT")
     { // HT
        if(GetItemPossessedBy(OBJECT_SELF,sVarName)!=OBJECT_INVALID)
          nDoAbortActs=FALSE;
     } // HT
     else if (sVarType=="HF")
     { // HF
        if(GetItemPossessedBy(OBJECT_SELF,sVarName)==OBJECT_INVALID)
          nDoAbortActs=FALSE;
     } // HF
     else if (sVarType=="Se")
     { // Se
       if (GetLocalString(OBJECT_SELF,sVarName)==GetLocalString(OBJECT_SELF,sAdd)) nDoAbortActs=FALSE;
     } // Se
     else if (sVarType=="Sn")
     { // Sn
       if (GetLocalString(OBJECT_SELF,sVarName)!=GetLocalString(OBJECT_SELF,sAdd)) nDoAbortActs=FALSE;
     } // Sn
     else if (sVarType=="Ie")
     { // Ie
      if (GetLocalInt(OBJECT_SELF,sVarName)==GetLocalInt(OBJECT_SELF,sAdd)) nDoAbortActs=FALSE;
     } // Ie
     else if (sVarType=="In")
     { // In
      if (GetLocalInt(OBJECT_SELF,sVarName)!=GetLocalInt(OBJECT_SELF,sAdd)) nDoAbortActs=FALSE;
     } // In
     else if (sVarType=="Ig")
     { // Ig
      if (GetLocalInt(OBJECT_SELF,sVarName)>GetLocalInt(OBJECT_SELF,sAdd)) nDoAbortActs=FALSE;
     } // Ig
     else if (sVarType=="Il")
     { // Il
      if (GetLocalInt(OBJECT_SELF,sVarName)<GetLocalInt(OBJECT_SELF,sAdd)) nDoAbortActs=FALSE;
     } // Il
     else if (sVarType=="UA")
     { // is an alignment
       nWork1=GetAlignmentGoodEvil(OBJECT_SELF);
       nWork2=GetAlignmentLawChaos(OBJECT_SELF);
       if (GetStringLeft(sVarName,1)=="L")
         nWork4=ALIGNMENT_LAWFUL;
       else if (GetStringLeft(sVarName,1)=="N"||GetStringLeft(sVarName,1)=="T")
         nWork4=ALIGNMENT_NEUTRAL;
       else if (GetStringLeft(sVarName,1)=="C")
         nWork4=ALIGNMENT_CHAOTIC;
       if (GetStringRight(sVarName,1)=="G")
         nWork3=ALIGNMENT_GOOD;
       else if (GetStringRight(sVarName,1)=="N")
         nWork3=ALIGNMENT_NEUTRAL;
       else if (GetStringRight(sVarName,1)=="E")
         nWork3=ALIGNMENT_EVIL;
       if (sVarName=="LAW")
       {
         nWork4=ALIGNMENT_LAWFUL;
         nWork3=0;
         nWork1=0;
       }
       else if (sVarName=="CHA")
       {
         nWork4=ALIGNMENT_CHAOTIC;
         nWork3=0;
         nWork1=0;
       }
       else if (sVarName=="GOO")
       {
         nWork3=ALIGNMENT_GOOD;
         nWork2=0;
         nWork4=0;
       }
       else if (sVarName=="EVI")
       {
         nWork3=ALIGNMENT_EVIL;
         nWork2=0;
         nWork4=0;
       }
       if (nWork1==nWork3&&nWork2==nWork4) nDoAbortActs=FALSE;
     } // is an alignment
     else if (sVarType=="UR")
     { // is a specific ResRef
       if (GetResRef(OBJECT_SELF)==sVarName) nDoAbortActs=FALSE;
     } // is a specific ResRef
     else if (sVarType=="US")
     { // is a specific tag
       if (GetTag(OBJECT_SELF)==sVarName) nDoAbortActs=FALSE;
     } // is a specific tag
     else if (sVarType=="UT")
     { // is a specific time of day
       if ((sVarName=="d"||sVarName=="D")&&GetIsDay()) nDoAbortActs=FALSE;
       else if ((sVarName=="n"||sVarName=="N")&&GetIsNight()) nDoAbortActs=FALSE;
       else if ((sVarName=="u"||sVarName=="U")&&GetIsDusk()) nDoAbortActs=FALSE;
       else if ((sVarName=="w"||sVarName=="W")&&GetIsDawn()) nDoAbortActs=FALSE;
     } // is a specific time of day
     else if (sVarName=="Uf")
     { // is female
       if (GetGender(OBJECT_SELF)==GENDER_FEMALE) nDoAbortActs=FALSE;
     } // is female
     else if (sVarName=="Um")
     { // is male
       if (GetGender(OBJECT_SELF)==GENDER_MALE) nDoAbortActs=FALSE;
     } // is male
     else if (sVarName=="UD")
     { // is Dwarf
       if (GetRacialType(OBJECT_SELF)==RACIAL_TYPE_DWARF) nDoAbortActs=FALSE;
     } // is dwarf
     else if (sVarName=="Ue")
     { // is Half-elf
       if (GetRacialType(OBJECT_SELF)==RACIAL_TYPE_HALFELF) nDoAbortActs=FALSE;
     } // is Half-elf
     else if (sVarName=="UE")
     { // is Elf
       if (GetRacialType(OBJECT_SELF)==RACIAL_TYPE_ELF) nDoAbortActs=FALSE;
     } // is Elf
     else if (sVarName=="UG")
     { // is Gnome
       if (GetRacialType(OBJECT_SELF)==RACIAL_TYPE_GNOME) nDoAbortActs=FALSE;
     } // is Gnome
     else if (sVarName=="Uh")
     { // is Halfling
       if (GetRacialType(OBJECT_SELF)==RACIAL_TYPE_HALFLING) nDoAbortActs=FALSE;
     } // is Halfling
     else if (sVarName=="UH")
     { // is Human
       if (GetRacialType(OBJECT_SELF)==RACIAL_TYPE_HUMAN) nDoAbortActs=FALSE;
     } // is Human
     else if (sVarName=="UO")
     { // is Half-Orc
       if (GetRacialType(OBJECT_SELF)==RACIAL_TYPE_HALFORC) nDoAbortActs=FALSE;
     } // is Half-Orc
     if (nDoAbortActs==TRUE)// abort further actions at this waypoint
     {
       SetLocalString(OBJECT_SELF,"sGNBActions","");
     }
     if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+":IF:"+sVarType+"("+sVarName+","+sAdd+")");
}// NPCAct3If()

//------------------------------------------------------[ WP ]-------------
void ACTNewWaypoint(string sIn)
{ // get the new waypoint destination [ turn .s into /s]
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+":[WP]:"+sIn);
  string sConvert;
  string sWork=GetStringRight(sIn,GetStringLength(sIn)-2); // strip WP
  while (GetStringLength(sWork)>0)
  { // convert . to _
    if (GetStringLeft(sWork,1)==".") sConvert=sConvert+"_";
    else
    {
      sConvert=sConvert+GetStringLeft(sWork,1);
    }
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  } // convert . to _
  if (DEEP_DEBUG_ON) GNBErrorReport("  >"+sConvert);
  SetLocalString(OBJECT_SELF,"sGNBDTag",sConvert);
} // ACTNewWaypoint()

//------------------------------------------------------[ RC ]--------------
void ACTRandomCommand(string sIn)
{ // handle random commands
  int nTotalCommands=StringToInt(GetStringRight(sIn,GetStringLength(sIn)-2));
  string sSnapshotActions=GetLocalString(OBJECT_SELF,"sGNBActions");
  string sActions=sSnapshotActions; // mess with this one
  string sCommand;
  string sStrip;
  int nRnd=Random(nTotalCommands)+1;
  int nC=0;
  while (nC<nRnd)
  { // get command to do
    sCommand=fnParsePeriod(sActions);
    sActions=fnStripStringSize(sActions,sCommand);
    nC++;
  } // get command to do
  sActions=sSnapshotActions;
  // strip the entire actions
  nC=0;
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" RANDOM COMMAND:"+IntToString(nTotalCommands));
  while (nC<nTotalCommands)
  {
    sStrip=fnParsePeriod(sActions);
    sActions=fnStripStringSize(sActions,sStrip);
    nC++;
    if (DEEP_DEBUG_ON) GNBErrorReport(IntToString(nC)+": "+sStrip);
  }
  sActions=sCommand+"."+sActions; // insert chosen command
  if (DEEP_DEBUG_ON) GNBErrorReport("  COMMAND:"+sCommand);
  SetLocalString(OBJECT_SELF,"sGNBActions",sActions);
} // ACTRandomCommand()

//-----------------------------------------------------[ FLEE ]-------------
void NPCActionFlee()
{
  int nLoop=1;
  int nStanding=0;
  float fDist;
  object oCreature=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nLoop);
  while(nLoop<10&&oCreature!=OBJECT_INVALID)
  { // while looking
    nStanding=GetFactionAverageReputation(oCreature,OBJECT_SELF);
    fDist=GetDistanceBetween(oCreature,OBJECT_SELF);
    if (fDist<15.0&&fDist!=0.0)
     if (nStanding<40) ActionMoveAwayFromObject(oCreature,TRUE);
    nLoop++;
    oCreature=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nLoop);
  } // while looking
} // NPCActionFlee()

//-------------------------------------------------------[ WAIT ]-----------
void ACTWait(string sIn)
{ // Wait #/# = #.# seconds
  string sWork=sIn;
  string sInt;
  string sDec;
  string sNum;
  float fTime;
  int nP=0;
  if (GetStringLeft(sWork,2)=="WT") sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
  else sWork=GetStringRight(sWork,GetStringLength(sWork)-4);
  while(GetStringLength(sWork)>0)
  { // build Integer/Decimal
    if (GetStringLeft(sWork,1)=="/") nP++;
    else if (nP==0)
       sInt=sInt+GetStringLeft(sWork,1);
    else
       sDec=sDec+GetStringLeft(sWork,1);
    sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  } // build Integer/Decimal
  sNum=sInt+"."+sDec; // build float
  fTime=StringToFloat(sNum);
  ActionWait(fTime);
  nP=FloatToInt(fTime/6.0);
  SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nP);
} // ACTWait()

//-----------------------------------------------------[ CAST ]---------
void NPCActionCastSpell(string sSpell)
{
  int nSpell=0;
  if (sSpell=="AID") nSpell=SPELL_AID;
  else if (sSpell=="AURAOFVITALITY") nSpell=SPELL_AURA_OF_VITALITY;
  else if (sSpell=="BARKSKIN") nSpell=SPELL_BARKSKIN;
  else if (sSpell=="BLESS") nSpell=SPELL_BLESS;
  else if (sSpell=="BULLSSTRENGTH") nSpell=SPELL_BULLS_STRENGTH;
  else if (sSpell=="CATSGRACE") nSpell=SPELL_CATS_GRACE;
  else if (sSpell=="CIRCLEOFDEATH") nSpell=SPELL_CIRCLE_OF_DEATH;
  else if (sSpell=="CIRCLEOFDOOM") nSpell=SPELL_CIRCLE_OF_DOOM;
  else if (sSpell=="CLOAKOFCHAOS") nSpell=SPELL_CLOAK_OF_CHAOS;
  else if (sSpell=="CLARITY") nSpell=SPELL_CLARITY;
  else if (sSpell=="CURECRITICALWOUNDS") nSpell=SPELL_CURE_CRITICAL_WOUNDS;
  else if (sSpell=="CURELIGHTWOUNDS") nSpell=SPELL_CURE_LIGHT_WOUNDS;
  else if (sSpell=="CUREMINORWOUNDS") nSpell=SPELL_CURE_MINOR_WOUNDS;
  else if (sSpell=="CUREMODERATEWOUNDS") nSpell=SPELL_CURE_MODERATE_WOUNDS;
  else if (sSpell=="CURESERIOUSWOUNDS") nSpell=SPELL_CURE_SERIOUS_WOUNDS;
  else if (sSpell=="DARKNESS") nSpell=SPELL_DARKNESS;
  else if (sSpell=="DARKVISION") nSpell=SPELL_DARKVISION;
  else if (sSpell=="DEATHWARD") nSpell=SPELL_DEATH_WARD;
  else if (sSpell=="DIVINEPOWER") nSpell=SPELL_DIVINE_POWER;
  else if (sSpell=="EAGLESPLENDOR") nSpell=SPELL_EAGLE_SPLEDOR;
  else if (sSpell=="ELEMENTALSHIELD") nSpell=SPELL_ELEMENTAL_SHIELD;
  else if (sSpell=="ENDURANCE") nSpell=SPELL_ENDURANCE;
  else if (sSpell=="ENDUREELEMENTS") nSpell=SPELL_ENDURE_ELEMENTS;
  else if (sSpell=="ENERGYBUFFER") nSpell=SPELL_ENERGY_BUFFER;
  else if (sSpell=="ETHEREALVISAGE") nSpell=SPELL_ETHEREAL_VISAGE;
  else if (sSpell=="FINDTRAPS") nSpell=SPELL_FIND_TRAPS;
  else if (sSpell=="FOXSCUNNING") nSpell=SPELL_FOXS_CUNNING;
  else if (sSpell=="FREEDOMOFMOVEMENT") nSpell=SPELL_FREEDOM_OF_MOVEMENT;
  else if (sSpell=="GATE") nSpell=SPELL_GATE;
  else if (sSpell=="GHOSTLYVISAGE") nSpell=SPELL_GHOSTLY_VISAGE;
  else if (sSpell=="GLOBEOFINVULNERABILITY") nSpell=SPELL_GLOBE_OF_INVULNERABILITY;
  else if (sSpell=="GREATERBULLSSTRENGTH") nSpell=SPELL_GREATER_BULLS_STRENGTH;
  else if (sSpell=="GREATERCATSGRACE") nSpell=SPELL_GREATER_CATS_GRACE;
  else if (sSpell=="GREATEREAGLESPLENDOR") nSpell=SPELL_GREATER_EAGLE_SPLENDOR;
  else if (sSpell=="GREATERENDURANCE") nSpell=SPELL_GREATER_ENDURANCE;
  else if (sSpell=="GREATERFOXSCUNNING") nSpell=SPELL_GREATER_FOXS_CUNNING;
  else if (sSpell=="GREATEROWLSWISDOM") nSpell=SPELL_GREATER_OWLS_WISDOM;
  else if (sSpell=="GREATERRESTORATION") nSpell=SPELL_GREATER_RESTORATION;
  else if (sSpell=="GREATERSTONESKIN") nSpell=SPELL_GREATER_STONESKIN;
  else if (sSpell=="HASTE") nSpell=SPELL_HASTE;
  else if (sSpell=="HEAL") nSpell=SPELL_HEAL;
  else if (sSpell=="HEALINGCIRCLE") nSpell=SPELL_HEALING_CIRCLE;
  else if (sSpell=="HOLYAURA") nSpell=SPELL_HOLY_AURA;
  else if (sSpell=="HOLYSWORD") nSpell=SPELL_HOLY_SWORD;
  else if (sSpell=="IDENTIFY") nSpell=SPELL_IDENTIFY;
  else if (sSpell=="IMPROVEDINVISIBILITY") nSpell=SPELL_IMPROVED_INVISIBILITY;
  else if (sSpell=="INVISIBILITY") nSpell=SPELL_INVISIBILITY;
  else if (sSpell=="INVISIBILITYSPHERE") nSpell=SPELL_INVISIBILITY_SPHERE;
  else if (sSpell=="LEGENDLORE") nSpell=SPELL_LEGEND_LORE;
  else if (sSpell=="LIGHT") nSpell=SPELL_LIGHT;
  else if (sSpell=="MAGEARMOR") nSpell=SPELL_MAGE_ARMOR;
  else if (sSpell=="MAGICCIRCLEAGAINSTCHAOS") nSpell=SPELL_MAGIC_CIRCLE_AGAINST_CHAOS;
  else if (sSpell=="MAGICCIRCLEAGAINSTEVIL") nSpell=SPELL_MAGIC_CIRCLE_AGAINST_EVIL;
  else if (sSpell=="MAGICCIRCLEAGAINSTGOOD") nSpell=SPELL_MAGIC_CIRCLE_AGAINST_GOOD;
  else if (sSpell=="MAGICCIRCLEAGAINSTLAW") nSpell=SPELL_MAGIC_CIRCLE_AGAINST_LAW;
  else if (sSpell=="MAGICVESTMENT") nSpell=SPELL_MAGIC_VESTMENT;
  else if (sSpell=="MASSHEAL") nSpell=SPELL_MASS_HEAL;
  else if (sSpell=="MINORGLOBEOFINVULNERABILITY") nSpell=SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
  else if (sSpell=="MORDENKAINENSSWORD") nSpell=SPELL_MORDENKAINENS_SWORD;
  else if (sSpell=="NEGATIVEENERGYPROTECTION") nSpell=SPELL_NEGATIVE_ENERGY_PROTECTION;
  else if (sSpell=="NEUTRALIZEPOISON") nSpell=SPELL_NEUTRALIZE_POISON;
  else if (sSpell=="OWLSWISDOM") nSpell=SPELL_OWLS_WISDOM;
  else if (sSpell=="PRAYER") nSpell=SPELL_PRAYER;
  else if (sSpell=="PREMONITION") nSpell=SPELL_PREMONITION;
  else if (sSpell=="PROTECTIONFROMCHAOS") nSpell=SPELL_PROTECTION__FROM_CHAOS;
  else if (sSpell=="PROTECTIONFROMELEMENTS") nSpell=SPELL_PROTECTION_FROM_ELEMENTS;
  else if (sSpell=="PROTECTIONFROMEVIL") nSpell=SPELL_PROTECTION_FROM_EVIL;
  else if (sSpell=="PROTECTIONFROMGOOD") nSpell=SPELL_PROTECTION_FROM_GOOD;
  else if (sSpell=="PROTECTIONFROMLAW") nSpell=SPELL_PROTECTION_FROM_LAW;
  else if (sSpell=="PROTECTIONFROMSPELLS") nSpell=SPELL_PROTECTION_FROM_SPELLS;
  else if (sSpell=="REGENERATE") nSpell=SPELL_REGENERATE;
  else if (sSpell=="REMOVEBLINDNESSANDDEAFNESS") nSpell=SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
  else if (sSpell=="REMOVECURSE") nSpell=SPELL_REMOVE_CURSE;
  else if (sSpell=="REMOVEDISEASE") nSpell=SPELL_REMOVE_DISEASE;
  else if (sSpell=="REMOVEFEAR") nSpell=SPELL_REMOVE_FEAR;
  else if (sSpell=="REMOVEPARALYSIS") nSpell=SPELL_REMOVE_PARALYSIS;
  else if (sSpell=="RESISTELEMENTS") nSpell=SPELL_RESIST_ELEMENTS;
  else if (sSpell=="RESISTANCE") nSpell=SPELL_RESISTANCE;
  else if (sSpell=="RESTORATION") nSpell=SPELL_RESTORATION;
  else if (sSpell=="SANCTUARY") nSpell=SPELL_SANCTUARY;
  else if (sSpell=="SEEINVISIBILITY") nSpell=SPELL_SEE_INVISIBILITY;
  else if (sSpell=="SHAPECHANGE") nSpell=SPELL_SHAPECHANGE;
  else if (sSpell=="SHIELDOFLAW") nSpell=SPELL_SHIELD_OF_LAW;
  else if (sSpell=="SPELLMANTLE") nSpell=SPELL_SPELL_MANTLE;
  else if (sSpell=="SPELLRESISTANCE") nSpell=SPELL_SPELL_RESISTANCE;
  else if (sSpell=="SPHEREOFCHAOS") nSpell=SPELL_SPHERE_OF_CHAOS;
  else if (sSpell=="STONESKIN") nSpell=SPELL_STONESKIN;
  else if (sSpell=="SUMMONCREATUREI") nSpell=SPELL_SUMMON_CREATURE_I;
  else if (sSpell=="SUMMONCREATUREII") nSpell=SPELL_SUMMON_CREATURE_II;
  else if (sSpell=="SUMMONCREATUREIII") nSpell=SPELL_SUMMON_CREATURE_III;
  else if (sSpell=="SUMMONCREATUREIV") nSpell=SPELL_SUMMON_CREATURE_IV;
  else if (sSpell=="SUMMONCREATUREV") nSpell=SPELL_SUMMON_CREATURE_V;
  else if (sSpell=="SUMMONCREATUREVI") nSpell=SPELL_SUMMON_CREATURE_VI;
  else if (sSpell=="SUMMONCREATUREVII") nSpell=SPELL_SUMMON_CREATURE_VII;
  else if (sSpell=="SUMMONCREATUREVIII") nSpell=SPELL_SUMMON_CREATURE_VIII;
  else if (sSpell=="SUMMONCREATUREIX") nSpell=SPELL_SUMMON_CREATURE_IX;
  else if (sSpell=="TENSERSTRANSFORMATION") nSpell=SPELL_TENSERS_TRANSFORMATION;
  else if (sSpell=="TIMESTOP") nSpell=SPELL_TIME_STOP;
  else if (sSpell=="TRUESEEING") nSpell=SPELL_TRUE_SEEING;
  else if (sSpell=="UNHOLYAURA") nSpell=SPELL_UNHOLY_AURA;
  else if (sSpell=="VIRTUE") nSpell=SPELL_VIRTUE;
  else if (sSpell=="WORDOFFAITH") nSpell=SPELL_WORD_OF_FAITH;
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+"  CAST SPELL ======>"+sSpell);
  if (nSpell!=0)
  { // spell is okay
    if (DEEP_DEBUG_ON)  GNBErrorReport("     SPELL IS VALID");
    /*if(GetHasSpell(nSpell,OBJECT_SELF)==TRUE)
    { // has the spell so cast it    */
      if (DEEP_DEBUG_ON)GNBErrorReport("     HAS SPELL, CAST IT!");
      ActionCastSpellAtObject(nSpell,OBJECT_SELF);
   // } // has the spell so cast it
  } // spell is okay
} // NPCActionCastSpell()

//---------------------------------------------------[ Cc ]----------------
void NPCAct4ChangeC(string sIn)
{ // change clothes <tag>
  string sClothResRef=GetStringRight(sIn,GetStringLength(sIn)-2);
  if (GetStringLength(sClothResRef)>2)
  { // we have clothing
    object oClothing=GetItemInSlot(INVENTORY_SLOT_CHEST); // currently wearing
    //SendMessageToPC(GetFirstPC(),"WEARING:"+GetTag(oClothing));
    if (sClothResRef!="NONE"&&GetResRef(oClothing)!=sClothResRef)
    { // create new clothing
     object oNewCloth=GetItemPossessedBy(OBJECT_SELF,sClothResRef);
     if (oNewCloth==OBJECT_INVALID)
      oNewCloth=CreateItemOnObject(sClothResRef);
     if (oNewCloth!=OBJECT_INVALID)
     { //!OI
       ActionEquipItem(oNewCloth,INVENTORY_SLOT_CHEST);
       //SendMessageToPC(GetFirstPC(),"CHANGED:"+GetTag(oNewCloth));
       ActionDoCommand(DestroyObject(oClothing)); // destroy old clothing
     } //!OI
    } // create new clothing
    else if (sClothResRef=="NONE")
      ActionDoCommand(DestroyObject(oClothing)); // destroy old clothin
   }// we have clothing
} // NPCAct4ChangeC()

//-------------------------------------------------[ LOCK / UNLOCK ]---------
void NPCAct4Locker(int nState)
{
  int nLoop=1;
  object oDoor=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nLoop);
  while(oDoor!=OBJECT_INVALID&&nLoop<10)
  { // test door
   if (GetLocked(oDoor)!=nState)
     nLoop=20;
   else
   {
     nLoop++;
     oDoor=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nLoop);
   }
  } // test door
  if (oDoor==OBJECT_INVALID)
  { // OI
    nLoop=1;
    oDoor=GetNearestObject(OBJECT_TYPE_PLACEABLE,OBJECT_SELF,nLoop);
    while(oDoor!=OBJECT_INVALID&&nLoop<10)
    { // test container
       if(GetLocked(oDoor)!=nState)
         nLoop=20;
       else
       {
         nLoop++;
         oDoor=GetNearestObject(OBJECT_TYPE_PLACEABLE,OBJECT_SELF,nLoop);
       }
    } // test container
  } // OI
  if (oDoor!=OBJECT_INVALID)
  { // okay lock/unlock it
    ActionMoveToObject(oDoor,FALSE,1.0);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);
    ActionDoCommand(AssignCommand(oDoor,SetLocked(oDoor,nState)));
  } // okay lock/unlock it
} // NPCACT4Locker()

//--------------------------------------------------------[ SFAC ]-----------
void NPCAct4SetFacing(string sFacing)
{
  string sRem="";
  if (GetStringLeft(sFacing,4)=="SFAC")
    sRem=GetStringRight(sFacing,GetStringLength(sFacing)-4);
  else
    sRem=GetStringRight(sFacing,GetStringLength(sFacing)-2);
  int nFacing=StringToInt(sRem);
  float fFacing=IntToFloat(nFacing);
  ActionDoCommand(SetFacing(fFacing));
} // NPCAct4SetFacing()

//---------------------------------------------------------[ DRD ]-----------
void NPCAct4RandomDoor()
{
  int nLoop=1;
  int nCount=0;
  object oDoor=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nLoop);
  while(nCount<10&&oDoor!=OBJECT_INVALID)
  { // door
    nCount++;
    nLoop++;
    oDoor=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nLoop);
  } // door
  nLoop=Random(nCount)+1;
  oDoor=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nLoop);
  SetLocalString(OBJECT_SELF,"sGNBDTag",GetTag(oDoor));
  SetLocalInt(OBJECT_SELF,"nGNBState",0);
} // NPCAct4RandomDoor()

//-----------------------------------------------------[ VFX/RVFX ]----------
void NPCAct4Visual(int nState, string sVFX)
{  // 0 = remove  1= apply
  string sParm="";
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+"[VFX]:"+sVFX);
  if (GetStringLeft(sVFX,3)=="VFX") sParm=GetStringRight(sVFX,GetStringLength(sVFX)-3);
  else if (GetStringLeft(sVFX,4)=="RVFX") sParm=GetStringRight(sVFX,GetStringLength(sVFX)-4);
  else if (GetStringLeft(sVFX,2)=="VF"||GetStringLeft(sVFX,2)=="RV")
   sParm=GetStringRight(sVFX,GetStringLength(sVFX)-2);
  int nVFX=StringToInt(sParm);
  if (DEEP_DEBUG_ON) GNBErrorReport("  nVFX:"+IntToString(nVFX)+" nState:"+IntToString(nState));
  effect eVFX=EffectVisualEffect(nVFX);
  if (GetIsEffectValid(eVFX))
  { // valid effect
    if (nState==0)
    { // remove effect
     effect eTest=GetFirstEffect(OBJECT_SELF);
     while(GetIsEffectValid(eVFX))
     { // test
       eTest=GetNextEffect(OBJECT_SELF);
       if (eTest==eVFX) RemoveEffect(OBJECT_SELF,eTest);
     } // test
    } // remove effect
    else
    { // apply effect
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVFX,OBJECT_SELF,5.0);
    } // apply effect
  } // valid effect
} // NPCAct4Visual()

//----------------------------------------------------[ POLY ]------------
void NPCAct4Polymorph(string sPoly)
{
  string sRem="";
  int nPoly=0;
  if (GetStringLeft(sPoly,4)=="POLY") sRem=GetStringRight(sPoly,GetStringLength(sPoly)-4);
  if (GetStringLeft(sPoly,2)=="PY") sRem=GetStringRight(sPoly,GetStringLength(sPoly)-2);
  nPoly=StringToInt(sRem);
  int nPolySug=POLYMORPH_TYPE_BADGER;
  if (nPoly==1) nPolySug=POLYMORPH_TYPE_BALOR;
  else if (nPoly==2) nPolySug=POLYMORPH_TYPE_BOAR;
  else if (nPoly==3) nPolySug=POLYMORPH_TYPE_BROWN_BEAR;
  else if (nPoly==4) nPolySug=POLYMORPH_TYPE_COW;
  else if (nPoly==5) nPolySug=POLYMORPH_TYPE_DEATH_SLAAD;
  else if (nPoly==6) nPolySug=POLYMORPH_TYPE_DIRE_BADGER;
  else if (nPoly==7) nPolySug=POLYMORPH_TYPE_DIRE_BOAR;
  else if (nPoly==8) nPolySug=POLYMORPH_TYPE_DIRE_BROWN_BEAR;
  else if (nPoly==9) nPolySug=POLYMORPH_TYPE_DIRE_PANTHER;
  else if (nPoly==10) nPolySug=POLYMORPH_TYPE_DIRE_WOLF;
  else if (nPoly==11) nPolySug=POLYMORPH_TYPE_DOOM_KNIGHT;
  else if (nPoly==12) nPolySug=POLYMORPH_TYPE_ELDER_AIR_ELEMENTAL;
  else if (nPoly==13) nPolySug=POLYMORPH_TYPE_ELDER_EARTH_ELEMENTAL;
  else if (nPoly==14) nPolySug=POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL;
  else if (nPoly==15) nPolySug=POLYMORPH_TYPE_ELDER_WATER_ELEMENTAL;
  else if (nPoly==16) nPolySug=POLYMORPH_TYPE_FIRE_GIANT;
  else if (nPoly==17) nPolySug=POLYMORPH_TYPE_GIANT_SPIDER;
  else if (nPoly==18) nPolySug=POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL;
  else if (nPoly==19) nPolySug=POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL;
  else if (nPoly==20) nPolySug=POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL;
  else if (nPoly==21) nPolySug=POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL;
  else if (nPoly==22) nPolySug=POLYMORPH_TYPE_IMP;
  else if (nPoly==23) nPolySug=POLYMORPH_TYPE_IRON_GOLEM;
  else if (nPoly==24) nPolySug=POLYMORPH_TYPE_PANTHER;
  else if (nPoly==25) nPolySug=POLYMORPH_TYPE_PENGUIN;
  else if (nPoly==26) nPolySug=POLYMORPH_TYPE_PIXIE;
  else if (nPoly==27) nPolySug=POLYMORPH_TYPE_QUASIT;
  else if (nPoly==28) nPolySug=POLYMORPH_TYPE_RED_DRAGON;
  else if (nPoly==29) nPolySug=POLYMORPH_TYPE_SUCCUBUS;
  else if (nPoly==30) nPolySug=POLYMORPH_TYPE_TROLL;
  else if (nPoly==31) nPolySug=POLYMORPH_TYPE_UMBER_HULK;
  else if (nPoly==32) nPolySug=POLYMORPH_TYPE_WERECAT;
  else if (nPoly==33) nPolySug=POLYMORPH_TYPE_WERERAT;
  else if (nPoly==34) nPolySug=POLYMORPH_TYPE_WEREWOLF;
  else if (nPoly==35) nPolySug=POLYMORPH_TYPE_WOLF;
  else if (nPoly==36) nPolySug=POLYMORPH_TYPE_YUANTI;
  else if (nPoly==37) nPolySug=POLYMORPH_TYPE_ZOMBIE;
  effect ePoly=EffectPolymorph(nPolySug);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePoly,OBJECT_SELF,30.0);
} // NPCAct4Polymorph()

//-----------------------------------------------------[ REACT ]-------------
void NPCAct4React()
{
  int nLoop=1;
  int nFound=FALSE;
  int nReact=0; // reaction type
  int nWork1;
  int nWork2;
  object oCreature=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nLoop);
  while (nLoop<10&&oCreature!=OBJECT_INVALID)
  { // while
    nWork1=GetHitDice(OBJECT_SELF);
    nWork2=GetHitDice(oCreature);
    if (nWork1<(nWork2-5))
    { // powerful character
      nReact=1;
      nLoop=20; // exit loop
    } // powerful character
    else
    { // wounded
      nWork1=GetMaxHitPoints(oCreature);
      nWork2=GetCurrentHitPoints(oCreature);
      if (nWork2<(nWork1/2))
      { // wounded character
        nReact=2;
        nLoop=20;
      } // wounded character
      else
      { // Large creature
        nWork1=GetCreatureSize(oCreature);
        if (nWork1==CREATURE_SIZE_HUGE||nWork1==CREATURE_SIZE_LARGE)
        { // big
          nReact=3;
          nLoop=20;
        } // big
        else
        { // faction not too liked
         nWork1=GetFactionAverageReputation(OBJECT_SELF,oCreature);
         if (nWork1<50)
         { // not liked
           nReact=4;
           nLoop=20;
         } // not liked
        } // faction not too liked
      } // Large creature
    } // wounded
    if(!nFound)
    { //!Found
     nLoop++;
     oCreature=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nLoop);
    } //!Found
  } // while
  if(nFound)
  { // act on the person
   nWork1=Random(3)+1;
   string sMsg="";
   switch(nReact)
   {// switch
    case 1: { // powerful character
     if (nWork1==1) sMsg="Wow! That guy looks formidable.";
     else if (nWork1==2) sMsg="Whoa, I wouldn't want to be in a dark alley along with that one.";
     else if (nWork1==3) sMsg="I'm sorry.  I didn't do anything but, I'll get it out of the way before I do.";
     SetFacing(GetFacing(oCreature));
     ActionSpeakString(sMsg);
     break;
    } // powerful character
    case 2: { // wounded
     if (nWork1==1) sMsg="Oh gosh, you need healing.";
     else if (nWork1==2) sMsg="Ummm... you're bleeding.";
     else if (nWork1==3) sMsg="You need to seek out a healer.  I would if I were you.";
     SetFacing(GetFacing(oCreature));
     ActionSpeakString(sMsg);
     break;
    } // wounded
    case 3: { // big
     if (nWork1==1) sMsg="BIG!!!!!!";
     else if (nWork1==2) sMsg="Wow!  I better watch where that steps.";
     else if (nWork1==3) sMsg="An earthquake?  No it's that big thing.";
     ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0,2.0);
     ActionSpeakString(sMsg);
     ActionMoveAwayFromObject(oCreature,TRUE,8.0);
     SetLocalInt(OBJECT_SELF,"nGNBMaxHB",3);
    } // big
    case 4: { // not liked
     if (nWork1==1) sMsg="Ughhh... there is a foul smell on the wind.";
     else if (nWork1==2) sMsg="They'll let anyone come here these days.";
     else if (nWork1==3) sMsg="Look what came in.  Better hide your orc piss or they might drink it.";
     ActionSpeakString(sMsg);
     ActionMoveAwayFromObject(oCreature,FALSE,25.0);
     SetLocalInt(OBJECT_SELF,"nGNBMaxHB",4);
     break;
    } // not liked
    default: break;
   } // switch
  } // act on the person
} // NPCAct4React()

//--------------------------------------------[ SLIS ]----------------------
void NPCAct4SetListen()
{
     SetListening(OBJECT_SELF,TRUE);
     SetListenPattern(OBJECT_SELF,"Did you hear**",112670);
     SetLocalString(OBJECT_SELF,"sGNBListen","Did you hear**");
     ACTScriptSet("$Dgennpc_userdef");
} // NPCAct4SetListen()

//---------------------------------------------[ SGOS ]---------------------
void NPCAct4SetGossip(string sListen)
{
  string sRem="";
  if(GetStringLeft(sListen,4)=="SGOS")
    sRem=GetStringRight(sListen,GetStringLength(sListen)-4);
  else
    sRem=GetStringRight(sListen,GetStringLength(sListen)-2);
  SetListenPattern(OBJECT_SELF,sRem+"**",112670);
  SetLocalString(OBJECT_SELF,"sGNBListen",sRem+"**");
} // NPCAct4SetGossip()

//-----------------------------------------------[ GOSSIP ]-----------------
void NPCAct4Gossip()
{
  int nHeard=GetLocalInt(OBJECT_SELF,"nDBWSStackGossipNum");
  string sPhrase;
  string sSay;
  string sListen=GetLocalString(OBJECT_SELF,"sGNBListen");
  int nRnd;
  sListen=GetStringLeft(sListen,GetStringLength(sListen)-2);
  if (nHeard==0)
  { // nothing to say
    nRnd=d4();
    if (nRnd==1)
      ActionSpeakString("I don't know anything of interest.");
    else if (nRnd==2)  ActionSpeakString("I wonder what happened to the good old '"+sListen+"' phrases?");
    else if (nRnd==3)  ActionSpeakString("I have not heard any decent gossip.");
    else if (nRnd==4)  ActionSpeakString("I have been listening but, have not heard any good gossip.");
  } // nothing to say
  else
  { // do gossip
    nHeard=Random(nHeard)+1;
    sSay="Gossip"+IntToString(nHeard);
    sPhrase=GetLocalString(OBJECT_SELF,sSay);
    ActionSpeakString(sListen+sPhrase);
  } // do gossip
} // NPCAct4Gossip()

//----------------------------------------------[ $ ]------------------------
void ACTScriptSet(string sIn)
{ // set the CRSP script
  string sWork=sIn;
  sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  string sNum=GetStringLeft(sWork,1);
  sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  string sScript="NONE";
  if (sNum=="1") sScript="sCRSPBlocked";
  else if (sNum=="2") sScript="sCRSPCRE";
  else if (sNum=="3") sScript="sCRSPConversation";
  else if (sNum=="4") sScript="sCRSPDamaged";
  else if (sNum=="5") sScript="sCRSPDeath";
  else if (sNum=="6") sScript="sCRSPDisturbed";
  else if (sNum=="7") sScript="sCRSPHB";
  else if (sNum=="8") sScript="sCRSPPerception";
  else if (sNum=="9") sScript="sCRSPPA";
  else if (sNum=="A") sScript="sCRSPRested";
  else if (sNum=="B") sScript="sCRSPSpawn";
  else if (sNum=="C") sScript="sCRSPSCA";
  else if (sNum=="D") sScript="sCRSPUser";
  else if (sNum=="E") sScript="sCRSPConvN";
  else if (sNum=="F") sScript="sCRSPConvA";
  if (sScript!="NONE")
  { // set the CRSP script
   SetLocalString(OBJECT_SELF,sScript,sWork);
  } // set the CRSP script
} // ACTScriptSet()


//------------------------------------------------------[ BS ]---------------
void ACTBaseScripts(string sIn)
{ // set the BASE scripts this NPC should use from this point on
  string sBase=GetStringRight(sIn,1);
  string sScript1="";
  string sScript2="";
  string sScript3="";
  string sScript4="";
  string sScript5="";
  string sScript6="";
  string sScript7="";
  string sScript8="";
  string sScript9="";
  string sScriptA="";
  string sScriptB="";
  string sScriptC="";
  string sScriptD="";
  string sScriptE="";
  string sScriptF="";
  // determine and set script variables here
  if (sBase=="1")
  { // Bioware Standard
    sScript1="nw_c2_defaulte";
    sScript2="nw_c2_default3";
    sScript3="nw_c2_default4";
    sScript4="nw_c2_default6";
    sScript5="nw_c2_default7";
    sScript6="nw_c2_default8";
    sScript7="nw_c2_default1";
    sScript8="nw_c2_default2";
    sScript9="nw_c2_default5";
    sScriptA="nw_c2_defaulta";
    sScriptB="nw_c2_default9";
    sScriptC="nw_c2_defaultb";
    sScriptD="nw_c2_defaultd";
    sScriptE="nw_walk_wp";
    sScriptF="nw_walk_wp";
  } // Bioware Standard
  else if (sBase=="2")
  { // Bioware Henchmen
    sScript1="nw_ch_ace";
    sScript2="nw_ch_ac3";
    sScript3="nw_ch_ac4";
    sScript4="nw_ch_ac6";
    sScript5="nw_ch_ac7";
    sScript6="nw_ch_ac8";
    sScript7="nw_ch_ac1";
    sScript8="nw_ch_ac2";
    sScript9="nw_ch_ac5";
    sScriptA="nw_ch_aca";
    sScriptB="nw_ch_ac9";
    sScriptC="nw_ch_acb";
    sScriptD="nw_ch_acd";
    sScriptE="nw_walk_wp";
    sScriptF="nw_walk_wp";
  } // Bioware Henchmen
  else if (sBase=="3")
  { // NPC ACTIVITIES CORE
    sScript1="nw_c2_defaulte";
    sScript2="nw_c2_default3";
    sScript3="nw_c2_default4";
    sScript4="nw_c2_default6";
    sScript5="nw_c2_default7";
    sScript6="nw_c2_default8";
    sScript7="gennpc_heartbeat";
    sScript8="nw_c2_default2";
    sScript9="nw_c2_default5";
    sScriptA="nw_c2_defaulta";
    sScriptB="gennpc_spawn";
    sScriptC="nw_c2_defaultb";
    sScriptD="nw_c2_defaultd";
    sScriptE="nw_walk_wp";
    sScriptF="nw_walk_wp";
  } // NPC ACTIVITIES CORE
  else if (sBase=="4")
  { // NPC ACTIVITIES PROFESSIONS
    sScript1="nw_c2_defaulte";
    sScript2="nw_c2_default3";
    sScript3="nw_c2_default4";
    sScript4="nw_c2_default6";
    sScript5="nw_c2_default7";
    sScript6="nw_c2_default8";
    sScript7="npcactp_heart";
    sScript8="nw_c2_default2";
    sScript9="gennpc_attacked";
    sScriptA="nw_c2_defaulta";
    sScriptB="gennpc_spawn";
    sScriptC="nw_c2_defaultb";
    sScriptD="nw_c2_defaultd";
    sScriptE="nw_walk_wp";
    sScriptF="nw_walk_wp";
  } // NPC ACTIVITIES PROFESSIONS
  else if (sBase=="5")
  { // NPC ACTIVITIES Memetics based
    sScript1="cb_blocked";
    sScript2="cb_combatend";
    sScript3="cb_conversation";
    sScript4="cb_damaged";
    sScript5="cb_death";
    sScript6="cb_disturbed";
    sScript7="cb_heartbeat";
    sScript8="cb_perception";
    sScript9="cb_attacked";
    sScriptA="cb_rested";
    sScriptB="cb_spawn";
    sScriptC="cb_spellcast";
    sScriptD="cb_userdefined";
    sScriptE="cb_talk_end";
    sScriptF="cb_talk_abort";
  } // NPC ACTIVITIES Memetics based
  // set these scripts
  ACTScriptSet("$1"+sScript1);
  ACTScriptSet("$2"+sScript2);
  ACTScriptSet("$3"+sScript3);
  ACTScriptSet("$4"+sScript4);
  ACTScriptSet("$5"+sScript5);
  ACTScriptSet("$6"+sScript6);
  ACTScriptSet("$7"+sScript7);
  ACTScriptSet("$8"+sScript8);
  ACTScriptSet("$9"+sScript9);
  ACTScriptSet("$A"+sScriptA);
  ACTScriptSet("$B"+sScriptB);
  ACTScriptSet("$C"+sScriptC);
  ACTScriptSet("$D"+sScriptD);
  ACTScriptSet("$E"+sScriptE);
  ACTScriptSet("$F"+sScriptF);
} // ACTBaseScripts()


//------------------------------------------------------[ BM ]----------------
void ACTBeamEffect(string sIn)
{ // Apply Beam effect ### to target with TAG
  string sWork=sIn;
  string sNum;
  string sTag;
  sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
  sNum=GetStringLeft(sWork,3);
  sTag=GetStringRight(sWork,GetStringLength(sWork)-3);
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" Beam Effect #"+sNum+" Target:"+sTag);
  effect eBeam=EffectBeam(StringToInt(sNum),OBJECT_SELF,BODY_NODE_HAND);
  object oTarget=GetNearestObjectByTag(sTag);
  if (oTarget!=OBJECT_INVALID)
  { // !OI
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,4.0);
  } // !OI
} // ACTBeamEffect()

//----------------------------------------------------[ CB ]-----------------
void ACTCombat(string sIn)
{ // Enter combat with creature with specific tag
  string sWork=sIn;
  sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
  object oTarget=GetNearestObjectByTag(sWork);
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" Combat with:"+GetName(oTarget));
  if (oTarget!=OBJECT_INVALID)
  { // !OI
    if (GetObjectType(oTarget)==OBJECT_TYPE_CREATURE&&GetDistanceBetween(OBJECT_SELF,oTarget)<10.0)
    { // is creature
      SetIsTemporaryEnemy(oTarget,OBJECT_SELF);
      SetIsTemporaryEnemy(OBJECT_SELF,oTarget);
      ActionAttack(oTarget);
      SetLocalObject(OBJECT_SELF,"oEnemy",oTarget);
      SetLocalObject(oTarget,"oEnemy",OBJECT_SELF);
    } // is creature
  } // !OI
} // ACTCombat()


//------------------------------------------------[ FXAR ]-------------------
void ACTFXAR(string sIn)
{ // apply effect ### to object
  string sWork=sIn;
  sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
  if (GetStringLeft(sWork,2)=="AR") sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
  string sNum=GetStringLeft(sWork,3);
  string sTag=GetStringRight(sWork,GetStringLength(sWork)-3);
  object oTarget=GetNearestObjectByTag(sTag);
  effect eVFX=EffectVisualEffect(StringToInt(sNum));
  if (oTarget!=OBJECT_INVALID)
  { // create visual effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVFX,GetLocation(oTarget),5.0);
  } // create visual effect
} // ACTFXAR()


void fnPersistentEffect(int Effect,int nDelay)
{ // Persistent effect called by Delay Command
  effect eFX=EffectVisualEffect(Effect);
  float fDelay=IntToFloat(nDelay)*0.2;
  object oMe=OBJECT_SELF;
  int nPFXCount=GetLocalInt(OBJECT_SELF,"nPFXCount");
  nPFXCount++;
  SetLocalInt(OBJECT_SELF,"nPFXCount",nPFXCount);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFX,oMe,30.0);
  DelayCommand(fDelay,AssignCommand(oMe,fnPersistentEffect(Effect,nDelay)));
} // fnPersistentEffect()

//-----------------------------------------------[ PFX ]-------------------
void ACTPFX(string sIn)
{ // apply persistent effect to NPC
  string sWork=sIn;
  string sEffectNum="";
  string sDelay="";
  int nPFXCount=GetLocalInt(OBJECT_SELF,"nPFXCount");
  int nPFXLCount=GetLocalInt(OBJECT_SELF,"nPFXLCount");
  SetLocalInt(OBJECT_SELF,"nPFXLCount",nPFXCount);
  if (nPFXCount==nPFXLCount)
  { // apply
  object oMe=OBJECT_SELF;
  sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
  if (GetStringLeft(sWork,1)=="X") sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  while(GetStringLeft(sWork,1)!="/"&&GetStringLength(sWork)>0)
  { // build effect num
    sEffectNum=sEffectNum+GetStringLeft(sWork,1);
    sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  } // build effect num
  if (GetStringLength(sWork)>0) sDelay=GetStringRight(sWork,GetStringLength(sWork)-1);
  AssignCommand(oMe,fnPersistentEffect(StringToInt(sEffectNum),StringToInt(sDelay)));
  SetLocalInt(OBJECT_SELF,"nPFXCount",0);
  SetLocalInt(OBJECT_SELF,"nPFXLCount",-1);
 } // apply
} // ACTPFX()

//-----------------------------------------[ TAKE ]-------------------------
void ACTTake(string sIn)
{ // Take an item by tag
  string sWork=sIn;
  object oItem;
  if (GetStringLeft(sWork,2)=="TK") sWork==GetStringRight(sWork,GetStringLength(sWork)-2);
  else if (GetStringLeft(sWork,4)=="TAKE") sWork=GetStringRight(sWork,GetStringLength(sWork)-4);
  oItem=GetNearestObjectByTag(sWork,OBJECT_SELF,1);
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" Take '"+sWork+"' NAME:"+GetName(oItem));
  if (GetDistanceBetween(oItem,OBJECT_SELF)>9.9) oItem=OBJECT_INVALID;
  if (oItem!=OBJECT_INVALID)
  { // !OI
    ActionPickUpItem(oItem);
  } // !OI
} // ACTTake()

//---------------------------------------------[ MAREA ]-------------------
void ACTMArea()
{ // Create NPC heartbeat monitor placeable npcact_marea_mon
  object oMonitor=GetLocalObject(OBJECT_SELF,"oMonitor");
  if (oMonitor==OBJECT_INVALID)
  { // no monitor create one
    oMonitor=CreateObject(OBJECT_TYPE_PLACEABLE,"npcact_marea_mon",GetLocation(OBJECT_SELF));
    SetLocalObject(OBJECT_SELF,"oMonitor",oMonitor);
    SetLocalObject(oMonitor,"oOwner",OBJECT_SELF);
  } // no monitor create one
} // ACTMArea()

//--------------------------------------------[ CP ]-------------------------
void ACTCPlaceable(string sIn)
{ // Create Placeable resref/tag
  string sParm=GetStringRight(sIn,GetStringLength(sIn)-2);
  string sRes=fnParseSlash(sParm);
  string sTag=fnStripStringSize(sParm,sRes);
  object oCreate;
  object oOb;
  if (GetStringLeft(sTag,1)=="/") sTag=GetStringRight(sTag,GetStringLength(sTag)-1);
  oOb=GetNearestObjectByTag(sTag,OBJECT_SELF,1);
  if (GetDistanceBetween(oOb,OBJECT_SELF)>10.0) oOb=OBJECT_INVALID;
  if (oOb!=OBJECT_INVALID)
  { // create at specific point
    ActionMoveToObject(oOb);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,5.0);
    oCreate=CreateObject(OBJECT_TYPE_PLACEABLE,sRes,GetLocation(oOb),TRUE);
    DelayCommand(5.0,AssignCommand(oCreate,SetFacing(GetFacing(oOb))));
  } // create at specific point
  else
  { // where you stand
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,5.0);
    oCreate=CreateObject(OBJECT_TYPE_PLACEABLE,sRes,GetLocation(OBJECT_SELF),TRUE);
    DelayCommand(5.0,AssignCommand(oCreate,SetFacing(GetFacing(OBJECT_SELF))));
  } // where you stand
} // ACTCPlaceable()

//---------------------------------------------[ DO ]------------------------
void ACTDObject(string sIn)
{ // Destroy Object by Tag
  string sParm=GetStringRight(sIn,GetStringLength(sIn)-2);
  object oOb=GetNearestObjectByTag(sParm,OBJECT_SELF,1);
  if (oOb!=OBJECT_INVALID)
  { //!OI
    if (GetDistanceBetween(oOb,OBJECT_SELF)<8.1)
    { // in range
      ActionMoveToObject(oOb);
      ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,5.0);
      DestroyObject(oOb,7.0);
    } // in range
  } //!OI
} // ACTDObject()

//--------------------------------------------[ AO ]-------------------------
void ACTAObject(string sIn)
{ // Attack Object by Tag
  string sParm=GetStringRight(sIn,GetStringLength(sIn)-2);
  object oOb=GetNearestObjectByTag(sParm,OBJECT_SELF,1);
  if (oOb!=OBJECT_INVALID)
  { // !OI
    if (GetDistanceBetween(oOb,OBJECT_SELF)<8.1)
    { // in range
      //NADisable();
      ActionMoveToObject(oOb,TRUE);
      ActionAttack(oOb,TRUE);
      ActionWait(2.0);
      ActionAttack(oOb,TRUE);
      //DelayCommand(18.0,NAEnable());
    } // in range
  } // !OI
} // ACTAObject();

//---------------------------------------------[ SITS ]----------------------
void ACTSitS(string sIn)
{ // Sit specified number of heartbeats
   string sParm=GetStringRight(sIn,GetStringLength(sIn)-4);
   int nHB=StringToInt(sParm);
   SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nHB);
   int nC=1;
  object oChair=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
     "(Chair|Couch|Stool|Bench / Pew|Throne - Evil|Throne - Good|InvisChair)",
     OBJECT_SELF,nC,5.0);
  while (oChair!=OBJECT_INVALID&&GetSittingCreature(oChair)!=OBJECT_INVALID)
  { // find an empty chair
    nC++;
    oChair=GetNearestObjectMatch(OBJECT_TYPE_PLACEABLE,
     "(Chair|Couch|Stool|Bench / Pew|Throne - Evil|Throne - Good|InvisChair)",
     OBJECT_SELF,nC,5.0);
  } // find an empty chair
  if (oChair!=OBJECT_INVALID)
  { // move and sit
    ActionMoveToObject(oChair);
    ActionSit(oChair);
  } // move and sit
  SetLocalInt(OBJECT_SELF,"nGNBDisabled",FALSE);
} // ACTSitS

string ALyric(string sIn)
{ // grab a section delimited by / and return the remainder
  string sRet=sIn;
  string sSing=fnParseSlash(sRet);
  sRet=fnStripStringSize(sRet,sSing);
  if (GetStringLeft(sRet,1)=="/") sRet=GetStringRight(sRet,GetStringLength(sRet)-1);
  NPCActSing(4.0,sSing);
  return sRet;
} // Alyric()

//----------------------------------------------[ LYRIC ]-------------------
void ACTLyrics(string sIn)
{ // Makes the NPC sing a specific song stored at a waypoint
  string sSong=sIn;
  if (GetStringLeft(sSong,5)=="LYRIC") sSong=GetStringRight(sSong,GetStringLength(sSong)-5);
  else if (GetStringLeft(sSong,2)=="LY") sSong=GetStringRight(sSong,GetStringLength(sSong)-2);
  object oWP=GetWaypointByTag(sSong);
  //if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+"[LYRICS]WP:"+sSong+" NAME:'"+GetName(oWP)+"'");
  int nC=1;
  if (oWP!=OBJECT_INVALID)
  { //!OI
    NADisable();
    sSong=GetName(oWP);
    while(GetStringLength(sSong)>0)
    {
      sSong=ALyric(sSong);
      nC++;
    }
    nC++;
    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);
    DelayCommand(IntToFloat(nC)*4.6,NAEnable());
    //if (DEEP_DEBUG_ON) GNBErrorReport("   Setting MaxHB="+IntToString(nC));
    SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nC);
  } //!OI
  else
    ActionSpeakString("Normally I would sing a nice song here but, I can't find my lyrics.");
} // ACTLyrics()

//----------------------------------------------[ RWL ]---------------------
void ACTRSpeak(string sIn)
{ // Speak a random phrase stored on a waypoint
  string sWP=sIn;
  if (GetStringLeft(sWP,3)=="RWL") sWP=GetStringRight(sWP,GetStringLength(sWP)-3);
  else if (GetStringLeft(sWP,2)=="RW") sWP=GetStringRight(sWP,GetStringLength(sWP)-2);
  object oWP=GetWaypointByTag(sWP);
  //if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+"[RWL]WP:"+sWP+" NAME:'"+GetName(oWP)+"'");
  int nCount;
  string sHeader;
  string sWork;
  int nRnd;
  if (oWP!=OBJECT_INVALID)
  { //!OI
    sHeader=GetName(oWP);
    nCount=0;
    while(GetStringLength(sHeader)>0&&nCount<NPCACT_MAX_SCAN)
    { // count entries
      nCount++;
      sWork=fnParseSlash(sHeader);
      //if (DEEP_DEBUG_ON) GNBErrorReport("  #"+IntToString(nCount)+" sWork:'"+sWork+"' sHeader:'"+sHeader+"'");
      sHeader=fnStripStringSize(sHeader,sWork);
      if (GetStringLeft(sHeader,1)=="/") sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-1);
    } // count entries
    if (nCount>0)
    { // there are phrases
      nRnd=Random(nCount)+1;
      sHeader=GetName(oWP);
      SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nCount+1);
      nCount=0;
      while(GetStringLength(sHeader)>0&&nCount<nRnd)
      { // get sentence
        nCount++;
        sWork=fnParseSlash(sHeader);
        sHeader=fnStripStringSize(sHeader,sWork);
        if (GetStringLeft(sHeader,1)=="/") sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-1);
      } // get sentence
      ActionSpeakString(sWork);
      ActionWait(1.5f);
    } // there are phrases
    else
     ActionSpeakString("There seems to be a lack of things for me to say.");
  } //!OI
  else
    ActionSpeakString("I can't think of anything to say.  I am at a LOSS for words.");
} // ACTRSpeak()


//------------------------------------------------------[ EFF ]-------------
void ACTEffects(string sIn)
{ // Visual effects applied to NPC
  string sParm=GetStringRight(sIn,GetStringLength(sIn)-3);
  string sVFX=fnParseSlash(sParm);
  sParm=fnStripStringSize(sParm,sVFX);
  if (GetStringLeft(sParm,1)=="/") sParm=GetStringRight(sParm,GetStringLength(sParm)-1);
  int nVFX=StringToInt(sVFX);
  float fDur=IntToFloat(StringToInt(sParm))*0.2;
  effect eVFX=EffectVisualEffect(nVFX);
  if (fDur==0.0)
  { // INSTANT
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,OBJECT_SELF,1.0);
  } // INSTANT
  else
  { // TEMPORARY
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVFX,OBJECT_SELF,fDur);
  } // TEMPORARY
} // ACTEffects()


//-----------------------------------------------------[ ANIM ]-------------
void ACTAnimate(string sIn)
{ // Apply animation for a duration
  string sParm=GetStringRight(sIn,GetStringLength(sIn)-4);
  string sAnim=fnParseSlash(sParm);
  sParm=fnStripStringSize(sParm,sAnim);
  if (GetStringLeft(sParm,1)=="/") sParm=GetStringRight(sParm,GetStringLength(sParm)-1);
  int nA=StringToInt(sAnim);
  float fDur=IntToFloat(StringToInt(sParm))*0.2;
  if (fDur>4.0) NADisable();
  int nAnimation=0;
  switch (nA)
  { // animation choose switch
    case 1: nAnimation=ANIMATION_FIREFORGET_BOW; break;
    case 2: nAnimation=ANIMATION_FIREFORGET_DRINK; break;
    case 3: nAnimation=ANIMATION_FIREFORGET_GREETING; break;
    case 4: nAnimation=ANIMATION_FIREFORGET_HEAD_TURN_LEFT; break;
    case 5: nAnimation=ANIMATION_FIREFORGET_HEAD_TURN_RIGHT; break;
    case 6: nAnimation=ANIMATION_FIREFORGET_PAUSE_BORED; break;
    case 7: nAnimation=ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD; break;
    case 8: nAnimation=ANIMATION_FIREFORGET_READ; break;
    case 9: nAnimation=ANIMATION_FIREFORGET_SALUTE; break;
    case 10: nAnimation=ANIMATION_FIREFORGET_STEAL; break;
    case 11: nAnimation=ANIMATION_FIREFORGET_TAUNT; break;
    case 12: nAnimation=ANIMATION_FIREFORGET_VICTORY1; break;
    case 13: nAnimation=ANIMATION_FIREFORGET_VICTORY2; break;
    case 14: nAnimation=ANIMATION_FIREFORGET_VICTORY3; break;
    case 15: nAnimation=ANIMATION_LOOPING_DEAD_FRONT; break;
    case 16: nAnimation=ANIMATION_LOOPING_GET_LOW; break;
    case 17: nAnimation=ANIMATION_LOOPING_GET_MID; break;
    case 18: nAnimation=ANIMATION_LOOPING_LISTEN; break;
    case 19: nAnimation=ANIMATION_LOOPING_LOOK_FAR; break;
    case 20: nAnimation=ANIMATION_LOOPING_MEDITATE; break;
    case 21: nAnimation=ANIMATION_LOOPING_PAUSE; break;
    case 22: nAnimation=ANIMATION_LOOPING_PAUSE_DRUNK; break;
    case 23: nAnimation=ANIMATION_LOOPING_PAUSE_TIRED; break;
    case 24: nAnimation=ANIMATION_LOOPING_PAUSE2; break;
    case 25: nAnimation=ANIMATION_LOOPING_SIT_CHAIR; break;
    case 26: nAnimation=ANIMATION_LOOPING_SIT_CROSS; break;
    case 27: nAnimation=ANIMATION_LOOPING_TALK_FORCEFUL; break;
    case 28: nAnimation=ANIMATION_LOOPING_TALK_LAUGHING; break;
    case 29: nAnimation=ANIMATION_LOOPING_TALK_NORMAL; break;
    case 30: nAnimation=ANIMATION_LOOPING_TALK_PLEADING; break;
    case 31: nAnimation=ANIMATION_LOOPING_WORSHIP; break;
    default: nAnimation=ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD; break;
  } // animation choose switch
  ActionPlayAnimation(nAnimation,1.0,fDur);
  nA=FloatToInt(fDur/6.0);
  nA++;
  if (fDur>4.0) DelayCommand(fDur,NAEnable());
  SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nA);
} // ACTAnimate()

//-----------------------------------------------[ TT ]---------------------
void ACTTalkTo(string sIn)
{ // Talk to object by TAG
  string sParm=GetStringRight(sIn,GetStringLength(sIn)-2);
  string sTag=fnParseSlash(sParm);
  sParm=fnStripStringSize(sParm,sTag);
  if (GetStringLeft(sParm,1)=="/") sParm=GetStringRight(sParm,GetStringLength(sParm)-1);
  object oTalkTo=GetNearestObjectByTag(sTag);
  if (oTalkTo!=OBJECT_INVALID&&GetDistanceBetween(OBJECT_SELF,oTalkTo)<10.1)
  { //!OI
    ActionMoveToObject(oTalkTo);
    if (sParm=="F") ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,5.0);
    else if (sParm=="P") ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0);
    else if (sParm=="N") ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,5.0);
    else if (sParm=="L") ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING,1.0,5.0);
    ActionStartConversation(oTalkTo);
  } //!OI
} // ACTTalkTo()

//-----------------------------------------------[ FOTG ]-------------------
void ACTFollowT(string sIn)
{ // Follow object by TAG
  string sParm=sIn;
  if (GetStringLeft(sParm,4)=="FOTG") sParm=GetStringRight(sParm,GetStringLength(sParm)-4);
  else sParm=GetStringRight(sParm,GetStringLength(sParm)-2);
  string sTag=fnParseSlash(sParm);
  sParm=fnStripStringSize(sParm,sTag);
  if (GetStringLeft(sParm,1)=="/") sParm=GetStringRight(sParm,GetStringLength(sParm)-1);
  object oTarget=GetNearestObjectByTag(sTag);
  if (oTarget!=OBJECT_INVALID&&GetDistanceBetween(OBJECT_SELF,oTarget)<10.1)
  { // !OI
    SetLocalInt(OBJECT_SELF,"nGNBMaxHB",StringToInt(sParm));
    ActionForceFollowObject(oTarget,3.0);
  } // !OI
} // ACTFollowT()

//----------------------------------------------[ LIBRARY CALL ]-------------
void ACTLibraryCall(string sIn)
{ // call a custom library
  string sParm=sIn;
  sParm=GetStringRight(sParm,GetStringLength(sParm)-1);
  string sLib=fnParseSlash(sParm);
  sParm=fnStripStringSize(sParm,sLib);
  if (GetStringLeft(sParm,1)=="/") sParm=GetStringRight(sParm,GetStringLength(sParm)-1);
  sLib="npcactdll"+sLib;
  SetLocalString(OBJECT_SELF,"sLIBParm",sParm);
  GNBErrorReport("[LIB CALL]"+GetTag(OBJECT_SELF)+" LIB='"+sLib+"'  PARMS:"+sParm);
  ExecuteScript(sLib,OBJECT_SELF);
} // ACTLibraryCall()
