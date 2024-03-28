
void ActionBuffSelf()
{
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(200), OBJECT_SELF);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,  EffectRegenerate(20, 1.0f), OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSummonCreature("NW_BEARDIREBOSS",VFX_BEAM_HOLY,0.5f), OBJECT_SELF);
}

/////////////////////////////////////////////////////////////
//:: Edit the commands below and replace "Prophesy 1" through
//:: "Prophesy 10" with your own plot honts.  Be sure your text
//:: is enclosed in parentheses.
/////////////////////////////////////////////////////////////
void ActionSpeakProphet()
{
        switch( Random(10))
        {
            case 0:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 1",TALKVOLUME_TALK));
               break;
            case 1:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 2",TALKVOLUME_TALK));
               break;
            case 2:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 3",TALKVOLUME_TALK));
               break;
            case 3:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 4",TALKVOLUME_TALK));
               break;
            case 4:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 5",TALKVOLUME_TALK));
               break;
            case 5:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 6",TALKVOLUME_TALK));
               break;
            case 6:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 7",TALKVOLUME_TALK));
               break;
            case 7:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 8",TALKVOLUME_TALK));
               break;
            case 8:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 9",TALKVOLUME_TALK));
               break;
            case 9:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Prophesy 10",TALKVOLUME_TALK));
               break;
        }
}







void ActionSpeakMad()
{
        switch( Random(137))
        {
            case 0:
               AssignCommand(OBJECT_SELF, ActionSpeakString("A shapely CATHOLIC SCHOOLGIRL is FIDGETING inside my costume..",TALKVOLUME_TALK));
               break;
            case 1:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Adopt my lifestyle or I'll have to press charges.",TALKVOLUME_TALK));
               break;
            case 2:
               AssignCommand(OBJECT_SELF, ActionSpeakString("All I can think of is a platter of organic PRUNE CRISPS being trampled by an army of swarthy, Italian LOUNGE SINGERS ...",TALKVOLUME_TALK));
               break;
            case 3:
               AssignCommand(OBJECT_SELF, ActionSpeakString("America!! I saw it all!!  Vomiting! Waving! JERRY FALWELLING into your void tube of UHF oblivion!!  SAFEWAY of the mind ...",TALKVOLUME_TALK));
               break;
            case 4:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Being a BALD HERO is almost as FESTIVE as a TATTOOED KNOCKWURST.",TALKVOLUME_TALK));
               break;
            case 5:
               AssignCommand(OBJECT_SELF, ActionSpeakString("BELA LUGOSI is my co-pilot ...",TALKVOLUME_TALK));
               break;
            case 6:
               AssignCommand(OBJECT_SELF, ActionSpeakString("BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-",TALKVOLUME_TALK));
               break;
            case 7:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... bleakness ... desolation ... plastic forks ...",TALKVOLUME_TALK));
               break;
            case 8:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Boy, am I glad it's only 1971...",TALKVOLUME_TALK));
               break;
            case 9:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Content: 80% POLYESTER, 20% DACRON ... The waitress's UNIFORM sheds TARTAR SAUCE like an 8 by 10 GLOSSY ...",TALKVOLUME_TALK));
               break;
            case 10:
               AssignCommand(OBJECT_SELF, ActionSpeakString("DON'T go!! I'm not HOWARD COSELL!! I know POLISH JOKES ...",TALKVOLUME_TALK));
               break;
            case 11:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Everywhere I look I see NEGATIVITY and ASPHALT ...",TALKVOLUME_TALK));
               break;
            case 12:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Frivolity is a stern taskmaster.",TALKVOLUME_TALK));
               break;
            case 13:
               AssignCommand(OBJECT_SELF, ActionSpeakString("FROZEN ENTREES may be flung by members of opposing SWANSON SECTS ...",TALKVOLUME_TALK));
               break;
            case 14:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Gibble, Gobble, we ACCEPT YOU ...",TALKVOLUME_TALK));
               break;
            case 15:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... he dominates the DECADENT SUBWAY SCENE.",TALKVOLUME_TALK));
               break;
            case 16:
               AssignCommand(OBJECT_SELF, ActionSpeakString("He is the MELBA-BEING ... the ANGEL CAKE ... XEROX him ...  XEROX him --",TALKVOLUME_TALK));
               break;
            case 17:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hello? Enema Bondage? I'm calling because I want to be happy, I guess ...",TALKVOLUME_TALK));
               break;
            case 18:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Here I am at the flea market but nobody is buying my urine sample bottles ...",TALKVOLUME_TALK));
               break;
            case 19:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hmmm ...  a CRIPPLED ACCOUNTANT with a FALAFEL sandwich is HIT by a TROLLEY-CAR ...",TALKVOLUME_TALK));
               break;
            case 20:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hmmm ... A hash-singer and a cross-eyed guy were SLEEPING on a deserted island, when ...",TALKVOLUME_TALK));
               break;
            case 21:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hmmm ... a PINHEAD, during an EARTHQUAKE, encounters an ALL-MIDGET FIDDLE ORCHESTRA ... ha ... ha ...",TALKVOLUME_TALK));
               break;
            case 22:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hmmm ... an arrogant bouquet with a subtle suggestion of POLYVINYL CHLORIDE ...",TALKVOLUME_TALK));
               break;
            case 23:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hold the MAYO & pass the COSMIC AWARENESS ...",TALKVOLUME_TALK));
               break;
            case 24:
               AssignCommand(OBJECT_SELF, ActionSpeakString("hubub, hubub, HUBUB, hubub, hubub, hubub, HUBUB, hubub, hubub, hubub.",TALKVOLUME_TALK));
               break;
            case 25:
               AssignCommand(OBJECT_SELF, ActionSpeakString("HUMAN REPLICAS are inserted into VATS of NUTRITIONAL YEAST ...",TALKVOLUME_TALK));
               break;
            case 26:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I am a jelly donut. I am a jelly donut.",TALKVOLUME_TALK));
               break;
            case 27:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I am NOT a nut....",TALKVOLUME_TALK));
               break;
            case 28:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I believe in wash fulfillment.",TALKVOLUME_TALK));
               break;
            case 29:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I can't think about that. It doesn't go with HEDGES in the shape of LITTLE LULU -- or ROBOTS making BRICKS ...",TALKVOLUME_TALK));
               break;
            case 30:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I don't know WHY I said that ... I think it came from the FILLINGS in my rear molars ...",TALKVOLUME_TALK));
               break;
            case 31:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I don't like FRANK SINATRA or his CHILDREN.",TALKVOLUME_TALK));
               break;
            case 32:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I feel ... JUGULAR ...",TALKVOLUME_TALK));
               break;
            case 33:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I feel like I am sharing a ``CORN-DOG'' with NIKITA KHRUSCHEV ...",TALKVOLUME_TALK));
               break;
            case 34:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I fill MY industrial waste containers with old copies of the WATCHTOWER and then add HAWAIIAN PUNCH to the top ... They look NICE in the yard ...",TALKVOLUME_TALK));
               break;
            case 35:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I guess it was all a DREAM ... or an episode of HAWAII FIVE-O ...",TALKVOLUME_TALK));
               break;
            case 36:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I had a lease on an OEDIPUS COMPLEX back in '81 ...",TALKVOLUME_TALK));
               break;
            case 37:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have a TINY BOWL in my HEAD",TALKVOLUME_TALK));
               break;
            case 38:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have a very good DENTAL PLAN. Thank you.",TALKVOLUME_TALK));
               break;
            case 39:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have many CHARTS and DIAGRAMS..",TALKVOLUME_TALK));
               break;
            case 40:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I have read the INSTRUCTIONS ...",TALKVOLUME_TALK));
               break;
            case 41:
               AssignCommand(OBJECT_SELF, ActionSpeakString("-- I have seen the FUN --",TALKVOLUME_TALK));
               break;
            case 42:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have seen these EGG EXTENDERS in my Supermarket ...",TALKVOLUME_TALK));
               break;
            case 43:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have seen these EGG EXTENDERS in my Supermarket ... I have read the INSTRUCTIONS ...",TALKVOLUME_TALK));
               break;
            case 44:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I hope I bought the right relish ...  zzzzzzzzz ...",TALKVOLUME_TALK));
               break;
            case 45:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I hope the ``Eurythmics'' practice birth control ...",TALKVOLUME_TALK));
               break;
            case 46:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just accepted provolone into my life.",TALKVOLUME_TALK));
               break;
            case 47:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just forgot my Social Security number.",TALKVOLUME_TALK));
               break;
            case 48:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just got my PRINCE bumper sticker ... But now I can't remember WHO he is ...",TALKVOLUME_TALK));
               break;
            case 49:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I like the way ONLY their mouths move ... They look like DYING OYSTERS",TALKVOLUME_TALK));
               break;
            case 50:
               AssignCommand(OBJECT_SELF, ActionSpeakString("-- I love KATRINKA because she drives a PONTIAC.  We're going away now. I fed the cat.",TALKVOLUME_TALK));
               break;
            case 51:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I put aside my copy of BOWLING WORLD and think about GUN CONTROL legislation..",TALKVOLUME_TALK));
               break;
            case 52:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I see TOILET SEATS ...",TALKVOLUME_TALK));
               break;
            case 53:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I think I'd better go back to my DESK and toy with a few common MISAPPREHENSIONS ...",TALKVOLUME_TALK));
               break;
            case 54:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I think I'm having a mid-week crisis.",TALKVOLUME_TALK));
               break;
            case 55:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want a mega-meal in a mega-mall.",TALKVOLUME_TALK));
               break;
            case 56:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want the presidency so bad I can already taste the hors d'oeuvres.",TALKVOLUME_TALK));
               break;
            case 57:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want to dress you up as TALLULAH BANKHEAD and cover you with VASELINE and WHEAT THINS ...",TALKVOLUME_TALK));
               break;
            case 58:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want to read my new poem about pork brains and outer space ...",TALKVOLUME_TALK));
               break;
            case 59:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want you to organize my PASTRY trays ... my TEA-TINS are gleaming in formation like a ROW of DRUM MAJORETTES -- please don't be FURIOUS with me --",TALKVOLUME_TALK));
               break;
            case 60:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I would like to urinate in an OVULAR, porcelain pool --",TALKVOLUME_TALK));
               break;
            case 61:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'd like some JUNK FOOD ... and then I want to be ALONE --",TALKVOLUME_TALK));
               break;
            case 62:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'll show you MY telex number if you show me YOURS ...",TALKVOLUME_TALK));
               break;
            case 63:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm a fuschia bowling ball somewhere in Brittany",TALKVOLUME_TALK));
               break;
            case 64:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm afraid! I need something in a heavy cream sauce.",TALKVOLUME_TALK));
               break;
            case 65:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm DESPONDENT ... I hope there's something DEEP-FRIED under this miniature DOMED STADIUM ...",TALKVOLUME_TALK));
               break;
            case 66:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm dressing up in an ill-fitting IVY-LEAGUE SUIT!! Too late...",TALKVOLUME_TALK));
               break;
            case 67:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having a RELIGIOUS EXPERIENCE ... and I don't take any DRUGS",TALKVOLUME_TALK));
               break;
            case 68:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having BEAUTIFUL THOUGHTS about the INSIPID WIVES of smug and wealthy CORPORATE LAWYERS ...",TALKVOLUME_TALK));
               break;
            case 69:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I'm IMAGINING a sensuous GIRAFFE, CAVORTING in the BACK ROOM of a KOSHER DELI --",TALKVOLUME_TALK));
               break;
            case 70:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm in direct contact with many advanced fun CONCEPTS.",TALKVOLUME_TALK));
               break;
            case 71:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm not available for comment..",TALKVOLUME_TALK));
               break;
            case 72:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm QUIETLY reading the latest issue of BOWLING WORLD while my wife and two children stand QUIETLY BY ...",TALKVOLUME_TALK));
               break;
            case 73:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm sitting on my SPEED QUEEN ... To me, it's ENJOYABLE ... I'm WARM ... I'm VIBRATORY ...",TALKVOLUME_TALK));
               break;
            case 74:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm thinking about DIGITAL READ-OUT systems and computer-generated IMAGE FORMATIONS ...",TALKVOLUME_TALK));
               break;
            case 75:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm totally DESPONDENT over the LIBYAN situation and the price of CHICKEN ...",TALKVOLUME_TALK));
               break;
            case 76:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I've got a COUSIN who works in the GARMENT DISTRICT ...",TALKVOLUME_TALK));
               break;
            case 77:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... ich bin in einem dusenjet ins jahr 53 vor chr ... ich lande im antiken Rom ... einige gladiatoren spielen scrabble ... ich rieche PIZZA ...",TALKVOLUME_TALK));
               break;
            case 78:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If you can't say something nice, say something surrealistic.",TALKVOLUME_TALK));
               break;
            case 79:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is he the MAGIC INCA carrying a FROG on his shoulders?? Is the FROG his GUIDELIGHT?? It is curious that a DOG runs already on the ESCALATOR ...",TALKVOLUME_TALK));
               break;
            case 80:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It's OKAY -- I'm an INTELLECTUAL, too.",TALKVOLUME_TALK));
               break;
            case 81:
               AssignCommand(OBJECT_SELF, ActionSpeakString("JAPAN is a WONDERFUL planet -- I wonder if we'll ever reach their level of COMPARATIVE SHOPPING ...",TALKVOLUME_TALK));
               break;
            case 82:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Jesus is my POSTMASTER GENERAL ...",TALKVOLUME_TALK));
               break;
            case 83:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Leona, I want to CONFESS things to you ... I want to WRAP you in a SCARLET ROBE trimmed with POLYVINYL CHLORIDE ... I want to EMPTY your ASHTRAYS ...",TALKVOLUME_TALK));
               break;
            case 84:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Let me do my TRIBUTE to FISHNET STOCKINGS ...",TALKVOLUME_TALK));
               break;
            case 85:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Look DEEP into the OPENINGS!!   Do you see any ELVES or EDSELS ... or a HIGHBALL?? ...",TALKVOLUME_TALK));
               break;
            case 86:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Maybe we could paint GOLDIE HAWN a rich PRUSSIAN BLUE --",TALKVOLUME_TALK));
               break;
            case 87:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Mmmmmm-MMMMMM!! A plate of STEAMING PIECES  of a PIG mixed with the shreds of SEVERAL CHICKENS!! ...",TALKVOLUME_TALK));
               break;
            case 88:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Oh BOY!! I'm about to swallow a TORN-OFF section of a COW'S LEFT LEG soaked in COTTONSEED OIL and SUGAR!! ...",TALKVOLUME_TALK));
               break;
            case 89:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Let's see ... Next, I'll have the GROUND-UP flesh of CUTE, BABY LAMBS fried in the MELTED, FATTY TISSUES from a warm-blooded animal someone once PETTED!! ...",TALKVOLUME_TALK));
               break;
            case 90:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My boxer shorts just went on a rampage through a Long Island bowling alley.",TALKVOLUME_TALK));
               break;
            case 91:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My LESLIE GORE record is BROKEN ...",TALKVOLUME_TALK));
               break;
            case 92:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My mind is a potato field ...",TALKVOLUME_TALK));
               break;
            case 93:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My mind is making ashtrays in Dayton ...",TALKVOLUME_TALK));
               break;
            case 94:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My nose feels like a bad Ronald Reagan movie ...",TALKVOLUME_TALK));
               break;
            case 95:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My vaseline is RUNNING...",TALKVOLUME_TALK));
               break;
            case 96:
               AssignCommand(OBJECT_SELF, ActionSpeakString("NATHAN ... your PARENTS were in a CARCRASH!! They're VOIDED -- They COLLAPSED They had no CHAINSAWS ... They had no MONEY MACHINES ... They did PILLS in SKIMPY GRASS SKIRTS ... Nathan, I EMULATED them ... but they were OFF-KEY ...",TALKVOLUME_TALK));
               break;
            case 97:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Nobody brings small problems into a laundromat.",TALKVOLUME_TALK));
               break;
            case 98:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I am depressed ...",TALKVOLUME_TALK));
               break;
            case 99:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I'm having INSIPID THOUGHTS about the beautiful, round wives of HOLLYWOOD MOVIE MOGULS encased in PLEXIGLASS CARS and being approached by SMALL BOYS selling FRUIT ...",TALKVOLUME_TALK));
               break;
            case 100:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now KEN and BARBIE are PERMANENTLY ADDICTED to MIND-ALTERING DRUGS ...",TALKVOLUME_TALK));
               break;
            case 101:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Of course, you UNDERSTAND about the PLAIDS in the SPIN CYCLE --",TALKVOLUME_TALK));
               break;
            case 102:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Okay ... I'm going home to write the I HATE RUBIK's CUBE HANDBOOK FOR DEAD CAT LOVERS ...",TALKVOLUME_TALK));
               break;
            case 103:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Once, there was NO fun ... This was before MENU planning, FASHION statements or NAUTILUS equipment ...",TALKVOLUME_TALK));
               break;
            case 104:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I will donate my entire BABY HUEY comic book collection to the downtown PLASMA CENTER ...",TALKVOLUME_TALK));
               break;
            case 105:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I won't START a BAND called KHADAFY & THE HIT SQUAD ...",TALKVOLUME_TALK));
               break;
            case 106:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Our father who art in heaven ... I sincerely pray that SOMEBODY at this table will PAY for my SHREDDED WHEAT and ENGLISH MUFFIN ... and also leave a GENEROUS TIP ....",TALKVOLUME_TALK));
               break;
            case 107:
               AssignCommand(OBJECT_SELF, ActionSpeakString("over in west Philadelphia a puppy is vomiting ...",TALKVOLUME_TALK));
               break;
            case 108:
               AssignCommand(OBJECT_SELF, ActionSpeakString("PEGGY FLEMMING is stealing BASKET BALLS to feed the babies in VERMONT.",TALKVOLUME_TALK));
               break;
            case 109:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Reality distorts my sense of television.",TALKVOLUME_TALK));
               break;
            case 110:
               AssignCommand(OBJECT_SELF, ActionSpeakString("SHHHH!! I hear SIX TATTOOED TRUCK-DRIVERS tossing ENGINE BLOCKS into empty OIL DRUMS ...",TALKVOLUME_TALK));
               break;
            case 111:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Sign my PETITION.",TALKVOLUME_TALK));
               break;
            case 112:
               AssignCommand(OBJECT_SELF, ActionSpeakString("So this is what it feels like to be potato salad",TALKVOLUME_TALK));
               break;
            case 113:
               AssignCommand(OBJECT_SELF, ActionSpeakString("someone in DAYTON, Ohio is selling USED CARPETS to a SERBO-CROATIAN",TALKVOLUME_TALK));
               break;
            case 114:
               AssignCommand(OBJECT_SELF, ActionSpeakString("TAILFINS!! ... click ...",TALKVOLUME_TALK));
               break;
            case 115:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Th'HOSTESS FACTORY is closin' down and I just heard ZASU PITTS has been DEAD for YEARS..",TALKVOLUME_TALK));
               break;
            case 116:
               AssignCommand(OBJECT_SELF, ActionSpeakString("(sniff) My PLATFORM SHOE collection was CHEWED up by th' dog.",TALKVOLUME_TALK));
               break;
            case 117:
               AssignCommand(OBJECT_SELF, ActionSpeakString("ALEXANDER HAIG won't let me take a SHOWER 'til Easter ...",TALKVOLUME_TALK));
               break;
            case 118:
               AssignCommand(OBJECT_SELF, ActionSpeakString("(snurf) So I went to the kitchen, but WALNUT PANELING whup me upside mah HAID!! (on no, no, no.. Heh, heh)",TALKVOLUME_TALK));
               break;
            case 119:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Th' MIND is the Pizza Palace of th' SOUL",TALKVOLUME_TALK));
               break;
            case 120:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The FALAFEL SANDWICH lands on my HEAD and I become a VEGETARIAN ...",TALKVOLUME_TALK));
               break;
            case 121:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The Korean War must have been fun.",TALKVOLUME_TALK));
               break;
            case 122:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The SAME WAVE keeps coming in and COLLAPSING like a rayon MUU-MUU ...",TALKVOLUME_TALK));
               break;
            case 123:
               AssignCommand(OBJECT_SELF, ActionSpeakString("This TOPS OFF my partygoing experience! Someone I DON'T LIKE is talking to me about a HEART-WARMING European film ...",TALKVOLUME_TALK));
               break;
            case 124:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Thousands of days of civilians ... have produced a ... feeling for the aesthetic modules --",TALKVOLUME_TALK));
               break;
            case 125:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Treasure your spin cycle.",TALKVOLUME_TALK));
               break;
            case 126:
               AssignCommand(OBJECT_SELF, ActionSpeakString("UH-OH!! I think KEN is OVER-DUE on his R.V. PAYMENTS and HE'S having a NERVOUS BREAKDOWN too!! Ha ha.",TALKVOLUME_TALK));
               break;
            case 127:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Virtual reality isn't what it used to be.",TALKVOLUME_TALK));
               break;
            case 128:
               AssignCommand(OBJECT_SELF, ActionSpeakString("We are now enjoying total mutual interaction in an imaginary hot tub ...",TALKVOLUME_TALK));
               break;
            case 129:
               AssignCommand(OBJECT_SELF, ActionSpeakString("We have DIFFERENT amounts of HAIR --",TALKVOLUME_TALK));
               break;
            case 130:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Well, I'm INVISIBLE AGAIN ... I might as well pay a visit to the LADIES ROOM ...",TALKVOLUME_TALK));
               break;
            case 131:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What I need is a MATURE RELATIONSHIP with a FLOPPY DISK ...",TALKVOLUME_TALK));
               break;
            case 132:
               AssignCommand(OBJECT_SELF, ActionSpeakString("When I met th'POPE back in '58, I scrubbed him with a MILD SOAP or DETERGENT for 15 minutes. He seemed to enjoy it ...",TALKVOLUME_TALK));
               break;
            case 133:
               AssignCommand(OBJECT_SELF, ActionSpeakString("When this load is DONE I think I'll wash it AGAIN ...",TALKVOLUME_TALK));
               break;
            case 134:
               AssignCommand(OBJECT_SELF, ActionSpeakString("With YOU, I can be MYSELF ... We don't NEED Dan Rather ...",TALKVOLUME_TALK));
               break;
            case 135:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Your CHEEKS sit like twin NECTARINES above a MOUTH that knows no BOUNDS --",TALKVOLUME_TALK));
               break;
            case 136:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Maybe I should have asked for my Neutron Bomb in PAISLEY --",TALKVOLUME_TALK));
               break;

        }
}















void ActionQueryMad()
{
        switch( Random(115))
        {
            case 0:
               AssignCommand(OBJECT_SELF, ActionSpeakString("A wide-eyed, innocent UNICORN, poised delicately in a MEADOW filled with LILACS, LOLLIPOPS & small CHILDREN at the HUSH of twilight??",TALKVOLUME_TALK));
               break;
            case 1:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Am I accompanied by a PARENT or GUARDIAN?",TALKVOLUME_TALK));
               break;
            case 2:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Am I elected yet?",TALKVOLUME_TALK));
               break;
            case 3:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Am I in GRADUATE SCHOOL yet?",TALKVOLUME_TALK));
               break;
            case 4:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Am I SHOPLIFTING?",TALKVOLUME_TALK));
               break;
            case 5:
               AssignCommand(OBJECT_SELF, ActionSpeakString("An INK-LING? Sure -- TAKE one!! Did you BUY any COMMUNIST UNIFORMS??",TALKVOLUME_TALK));
               break;
            case 6:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are the STEWED PRUNES still in the HAIR DRYER?",TALKVOLUME_TALK));
               break;
            case 7:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are we live or on tape?",TALKVOLUME_TALK));
               break;
            case 8:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are we on STRIKE yet?",TALKVOLUME_TALK));
               break;
            case 9:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are we THERE yet?",TALKVOLUME_TALK));
               break;
            case 10:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are you mentally here at Pizza Hut??",TALKVOLUME_TALK));
               break;
            case 11:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are you still an ALCOHOLIC?",TALKVOLUME_TALK));
               break;
            case 12:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Awright, which one of you hid my PENIS ENVY?",TALKVOLUME_TALK));
               break;
            case 13:
               AssignCommand(OBJECT_SELF, ActionSpeakString("But was he mature enough last night at the lesbian masquerade?",TALKVOLUME_TALK));
               break;
            case 14:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Can I have an IMPULSE ITEM instead?",TALKVOLUME_TALK));
               break;
            case 15:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Can you MAIL a BEAN CAKE?",TALKVOLUME_TALK));
               break;
            case 16:
               AssignCommand(OBJECT_SELF, ActionSpeakString("CONGRATULATIONS! Now should I make thinly veiled comments about DIGNITY, self-esteem and finding TRUE FUN in your RIGHT VENTRICLE??",TALKVOLUME_TALK));
               break;
            case 17:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Could I have a drug overdose?",TALKVOLUME_TALK));
               break;
            case 18:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Did an Italian CRANE OPERATOR just experience uninhibited sensations in a MALIBU HOT TUB?",TALKVOLUME_TALK));
               break;
            case 19:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Did I do an INCORRECT THING??",TALKVOLUME_TALK));
               break;
            case 20:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Did I say I was a sardine? Or a bus???",TALKVOLUME_TALK));
               break;
            case 21:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Did I SELL OUT yet??",TALKVOLUME_TALK));
               break;
            case 22:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Did YOU find a DIGITAL WATCH in YOUR box of VELVEETA?",TALKVOLUME_TALK));
               break;
            case 23:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Did you move a lot of KOREAN STEAK KNIVES this trip, Dingy?",TALKVOLUME_TALK));
               break;
            case 24:
               AssignCommand(OBJECT_SELF, ActionSpeakString("DIDI ... is that a MARTIAN name, or, are we in ISRAEL?",TALKVOLUME_TALK));
               break;
            case 25:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Didn't I buy a 1951 Packard from you last March in Cairo?",TALKVOLUME_TALK));
               break;
            case 26:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Do I have a lifestyle yet?",TALKVOLUME_TALK));
               break;
            case 27:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Do you guys know we just passed thru a BLACK HOLE in space?",TALKVOLUME_TALK));
               break;
            case 28:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Do you have exactly what I want in a plaid poindexter bar bat??",TALKVOLUME_TALK));
               break;
            case 29:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Do you like TENDER VITTLES?",TALKVOLUME_TALK));
               break;
            case 30:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Do you think the Monkees should get gas on odd or even days?",TALKVOLUME_TALK));
               break;
            case 31:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Does someone from PEORIA have a SHORTER ATTENTION span than me?",TALKVOLUME_TALK));
               break;
            case 32:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Does your DRESSING ROOM have enough ASPARAGUS?",TALKVOLUME_TALK));
               break;
            case 33:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Don't worry, nobody really LISTENS to lectures in MOSCOW, either! ... FRENCH, HISTORY, ADVANCED CALCULUS, COMPUTER PROGRAMMING, BLACK STUDIES, SOCIOBIOLOGY! ... Are there any QUESTIONS??",TALKVOLUME_TALK));
               break;
            case 34:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Excuse me, but didn't I tell you there's NO HOPE for the survival of  OFFSET PRINTING?",TALKVOLUME_TALK));
               break;
            case 35:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Has everybody got HALVAH spread all over their ANKLES??",TALKVOLUME_TALK));
               break;
            case 36:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Here we are in America ... when do we collect unemployment?",TALKVOLUME_TALK));
               break;
            case 37:
               AssignCommand(OBJECT_SELF, ActionSpeakString("How do I get HOME?",TALKVOLUME_TALK));
               break;
            case 38:
               AssignCommand(OBJECT_SELF, ActionSpeakString("How many retired bricklayers from FLORIDA are out purchasing PENCIL SHARPENERS right NOW??",TALKVOLUME_TALK));
               break;
            case 39:
               AssignCommand(OBJECT_SELF, ActionSpeakString("How's it going in those MODULAR LOVE UNITS??",TALKVOLUME_TALK));
               break;
            case 40:
               AssignCommand(OBJECT_SELF, ActionSpeakString("How's the wife? Is she at home enjoying capitalism?",TALKVOLUME_TALK));
               break;
            case 41:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I am having FUN... I wonder if it's NET FUN or GROSS FUN?",TALKVOLUME_TALK));
               break;
            case 42:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I KAISER ROLL?! What good is a Kaiser Roll without a little COLE SLAW on the SIDE?",TALKVOLUME_TALK));
               break;
            case 43:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I wonder if I could ever get started in the credit world?",TALKVOLUME_TALK));
               break;
            case 44:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I wonder if I ought to tell them about my PREVIOUS LIFE as a COMPLETE STRANGER?",TALKVOLUME_TALK));
               break;
            case 45:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I wonder if there's anything GOOD on tonight?",TALKVOLUME_TALK));
               break;
            case 46:
               AssignCommand(OBJECT_SELF, ActionSpeakString("But, uh, WHY is there a WAFFLE in my PAJAMA POCKET??",TALKVOLUME_TALK));
               break;
            case 47:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm mentally OVERDRAWN! What's that SIGNPOST up ahead? Where's ROD STERLING when you really need him?",TALKVOLUME_TALK));
               break;
            case 48:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm pretending I'm pulling in a TROUT! Am I doing it correctly??",TALKVOLUME_TALK));
               break;
            case 49:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If Robert Di Niro assassinates Walter Slezak, will Jodie Foster marry Bonzo??",TALKVOLUME_TALK));
               break;
            case 50:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is a tattoo real, like a curb or a battleship? Or are we suffering in Safeway?",TALKVOLUME_TALK));
               break;
            case 51:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is it 1974?  What's for SUPPER? Can I spend my COLLEGE FUND in one wild afternoon??",TALKVOLUME_TALK));
               break;
            case 52:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is it clean in other dimensions?",TALKVOLUME_TALK));
               break;
            case 53:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is it NOUVELLE CUISINE when 3 olives are struggling with a scallop in a plate of SAUCE MORNAY?",TALKVOLUME_TALK));
               break;
            case 54:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is something  VIOLENT going to happen to a GARBAGE CAN?",TALKVOLUME_TALK));
               break;
            case 55:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is this an out-take from the BRADY BUNCH?",TALKVOLUME_TALK));
               break;
            case 56:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is this going to involve RAW human ecstasy?",TALKVOLUME_TALK));
               break;
            case 57:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is this TERMINAL fun?",TALKVOLUME_TALK));
               break;
            case 58:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is this the line for the latest whimsical YUGOSLAVIAN drama which also makes you want to CRY and reconsider the VIETNAM WAR?",TALKVOLUME_TALK));
               break;
            case 59:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It's a lot of fun being alive ... I wonder if my bed is made?!?",TALKVOLUME_TALK));
               break;
            case 60:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Mr and Mrs PED, can I borrow 26.7% of the RAYON TEXTILE production of the INDONESIAN archipelago?",TALKVOLUME_TALK));
               break;
            case 61:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Oh, I get it!! The BEACH goes on, huh, SONNY??",TALKVOLUME_TALK));
               break;
            case 62:
               AssignCommand(OBJECT_SELF, ActionSpeakString("OMNIVERSAL AWARENESS?? Oh, YEH!! First you need 4 GALLONS of JELL-O and a BIG WRENCH!! ... I think you drop th'WRENCH in the JELL-O as if it was a FLAVOR, or an INGREDIENT ... ... or ... I ... um ... WHERE'S the WASHING MACHINES?",TALKVOLUME_TALK));
               break;
            case 63:
               AssignCommand(OBJECT_SELF, ActionSpeakString(".. or were you driving the PONTIAC that HONKED at me in MIAMI last Tuesday?",TALKVOLUME_TALK));
               break;
            case 64:
               AssignCommand(OBJECT_SELF, ActionSpeakString("PARDON me, am I speaking ENGLISH?",TALKVOLUME_TALK));
               break;
            case 65:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Should I do my BOBBIE VINTON medley?",TALKVOLUME_TALK));
               break;
            case 66:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Should I get locked in the PRINCICAL'S OFFICE today -- or have a VASECTOMY??",TALKVOLUME_TALK));
               break;
            case 67:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Should I start with the time I SWITCHED personalities with a BEATNIK hair stylist or my failure to refer five TEENAGERS to a good OCULIST?",TALKVOLUME_TALK));
               break;
            case 68:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Spreading peanut butter reminds me of opera!! I wonder why?",TALKVOLUME_TALK));
               break;
            case 69:
               AssignCommand(OBJECT_SELF, ActionSpeakString("TONY RANDALL! Is YOUR life a PATIO of FUN??",TALKVOLUME_TALK));
               break;
            case 70:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Uh-oh -- WHY am I suddenly thinking of a VENERABLE religious leader frolicking on a FORT LAUDERDALE weekend?",TALKVOLUME_TALK));
               break;
            case 71:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Wait ... is this a FUN THING or the END of LIFE in Petticoat Junction??",TALKVOLUME_TALK));
               break;
            case 72:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Were these parsnips CORRECTLY MARINATED in TACO SAUCE?",TALKVOLUME_TALK));
               break;
            case 73:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What GOOD is a CARDBOARD suitcase ANYWAY?",TALKVOLUME_TALK));
               break;
            case 74:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What I want to find out is -- do parrots know much about Astro-Turf?",TALKVOLUME_TALK));
               break;
            case 75:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What PROGRAM are they watching?",TALKVOLUME_TALK));
               break;
            case 76:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What UNIVERSE is this, please??",TALKVOLUME_TALK));
               break;
            case 77:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What's the MATTER Sid? ... Is your BEVERAGE unsatisfactory?",TALKVOLUME_TALK));
               break;
            case 78:
               AssignCommand(OBJECT_SELF, ActionSpeakString("When you get your PH.D. will you get able to work at BURGER KING?",TALKVOLUME_TALK));
               break;
            case 79:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Where do your SOCKS go when you lose them in th' WASHER?",TALKVOLUME_TALK));
               break;
            case 80:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Where does it go when you flush?",TALKVOLUME_TALK));
               break;
            case 81:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Where's SANDY DUNCAN?",TALKVOLUME_TALK));
               break;
            case 82:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Where's th' DAFFY DUCK EXHIBIT??",TALKVOLUME_TALK));
               break;
            case 83:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Why are these athletic shoe salesmen following me??",TALKVOLUME_TALK));
               break;
            case 84:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Why don't you ever enter and CONTESTS, Marvin?? Don't you know your own ZIPCODE?",TALKVOLUME_TALK));
               break;
            case 85:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Why is everything made of Lycra Spandex?",TALKVOLUME_TALK));
               break;
            case 86:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Why is it that when you DIE, you can't take your HOME ENTERTAINMENT CENTER with you??",TALKVOLUME_TALK));
               break;
            case 87:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Will it improve my CASH FLOW?",TALKVOLUME_TALK));
               break;
            case 88:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Will the third world war keep Bosom Buddies off the air?",TALKVOLUME_TALK));
               break;
            case 89:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Will this never-ending series of PLEASURABLE EVENTS never cease?",TALKVOLUME_TALK));
               break;
            case 90:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Yes, but will I see the EASTER BUNNY in skintight leather at an IRON MAIDEN concert?",TALKVOLUME_TALK));
               break;
            case 91:
               AssignCommand(OBJECT_SELF, ActionSpeakString("You mean now I can SHOOT YOU in the back and further BLUR th' distinction between FANTASY and REALITY?",TALKVOLUME_TALK));
               break;
            case 92:
               AssignCommand(OBJECT_SELF, ActionSpeakString("You mean you don't want to watch WRESTLING from ATLANTA?",TALKVOLUME_TALK));
               break;
            case 93:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Am I in Milwaukee?",TALKVOLUME_TALK));
               break;
            case 94:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are we laid back yet?",TALKVOLUME_TALK));
               break;
            case 95:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are we wet yet?",TALKVOLUME_TALK));
               break;
            case 96:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are you the self-frying president?",TALKVOLUME_TALK));
               break;
            case 97:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Did something bad happen or am I in a drive-in movie??",TALKVOLUME_TALK));
               break;
            case 98:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is my fallout shelter termite proof?",TALKVOLUME_TALK));
               break;
            case 99:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Is this sexual intercourse yet?? Is it, huh, is it??",TALKVOLUME_TALK));
               break;
            case 100:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are we THERE yet? My MIND is a SUBMARINE!!",TALKVOLUME_TALK));
               break;
            case 101:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Are you selling NYLON OIL WELLS?? If so, we can use TWO DOZEN!!",TALKVOLUME_TALK));
               break;
            case 102:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Has everybody got HALVAH spread all over their ANKLES?? ...  Now, it's time to HAVE A NAGEELA!!",TALKVOLUME_TALK));
               break;
            case 103:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hello... IRON CURTAIN? Send over a SAUSAGE PIZZA! World War III? No thanks!",TALKVOLUME_TALK));
               break;
            case 104:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Isn't this my STOP?!",TALKVOLUME_TALK));
               break;
            case 105:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It was a JOKE!! Get it?? I was receiving messages from DAVID LETTERMAN!! YOW!!",TALKVOLUME_TALK));
               break;
            case 106:
               AssignCommand(OBJECT_SELF, ActionSpeakString("LBJ, LBJ, how many JOKES did you tell today??!",TALKVOLUME_TALK));
               break;
            case 107:
               AssignCommand(OBJECT_SELF, ActionSpeakString("NANCY!! Why is everything RED?!",TALKVOLUME_TALK));
               break;
            case 108:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Psychoanalysis?? I thought this was a nude rap session!!!",TALKVOLUME_TALK));
               break;
            case 109:
               AssignCommand(OBJECT_SELF, ActionSpeakString("TAPPING? You POLITICIANS! Don't you realize that the END of the Wash Cycle is a TREASURED MOMENT for most people?!",TALKVOLUME_TALK));
               break;
            case 110:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Was my SOY LOAF left out in th'RAIN? It tastes REAL GOOD!!",TALKVOLUME_TALK));
               break;
            case 111:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Where's the Coke machine? Tell me a joke!!",TALKVOLUME_TALK));
               break;
            case 112:
               AssignCommand(OBJECT_SELF, ActionSpeakString("WHO sees a BEACH BUNNY sobbing on a SHAG RUG?!",TALKVOLUME_TALK));
               break;
            case 113:
               AssignCommand(OBJECT_SELF, ActionSpeakString("World War III? No thanks!",TALKVOLUME_TALK));
               break;
            case 114:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What should the entire human race DO??   Consume a fifth of CHIVAS REGAL, ski NUDE down MT. EVEREST, and have a wild SEX WEEKEND!",TALKVOLUME_TALK));
               break;
      }
}




//********************************************************
//********************************************************
//********************************************************
void ActionExclaimMad()
{
        switch( Random(302))
        {
            case 0:
               AssignCommand(OBJECT_SELF, ActionSpeakString("A can of ASPARAGUS, 73 pigeons, some LIVE ammo, and a FROZEN DAIQUIRI!!"));
               break;
            case 1:
               AssignCommand(OBJECT_SELF, ActionSpeakString("A dwarf is passing out somewhere in Detroit!"));
               break;
            case 2:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Actually, what I'd like is a little toy spaceship!!"));
               break;
            case 3:
               AssignCommand(OBJECT_SELF, ActionSpeakString("All of a sudden, I want to THROW OVER my promising ACTING CAREER, grow a LONG BLACK BEARD and wear a BASEBALL HAT!!  ... Although I don't know WHY!!"));
               break;
            case 4:
               AssignCommand(OBJECT_SELF, ActionSpeakString("All of life is a blur of Republicans and meat!"));
               break;
            case 5:
               AssignCommand(OBJECT_SELF, ActionSpeakString("All right, you degenerates! I want this place evacuated in 20 seconds!"));
               break;
            case 6:
               AssignCommand(OBJECT_SELF, ActionSpeakString("All this time I've been VIEWING a RUSSIAN MIDGET SODOMIZE a HOUSECAT!"));
               break;
            case 7:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Alright, you!! Imitate a WOUNDED SEAL pleading for a PARKING SPACE!!"));
               break;
            case 8:
               AssignCommand(OBJECT_SELF, ActionSpeakString("An air of FRENCH FRIES permeates my nostrils!!"));
               break;
            case 9:
               AssignCommand(OBJECT_SELF, ActionSpeakString("An Italian is COMBING his hair in suburban DES MOINES!"));
               break;
            case 10:
               AssignCommand(OBJECT_SELF, ActionSpeakString("And furthermore, my bowling average is unimpeachable!!!"));
               break;
            case 11:
               AssignCommand(OBJECT_SELF, ActionSpeakString("ANN JILLIAN'S HAIR makes LONI ANDERSON'S HAIR look like RICARDO MONTALBAN'S HAIR!"));
               break;
            case 12:
               AssignCommand(OBJECT_SELF, ActionSpeakString("As President I have to go vacuum my coin collection!"));
               break;
            case 13:
               AssignCommand(OBJECT_SELF, ActionSpeakString("BARBARA STANWYCK makes me nervous!!"));
               break;
            case 14:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Barbie says, Take quaaludes in gin and go to a disco right away! But Ken says, WOO-WOO!! No credit at  Mr. Liquor !!"));
               break;
            case 15:
               AssignCommand(OBJECT_SELF, ActionSpeakString("BARRY ... That was the most HEART-WARMING rendition of  I DID IT MY WAY  I've ever heard!!"));
               break;
            case 16:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Boys, you have ALL been selected to LEAVE th' PLANET in 15 minutes!!"));
               break;
            case 17:
               AssignCommand(OBJECT_SELF, ActionSpeakString("But they went to MARS around 1953!!"));
               break;
            case 18:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Catsup and Mustard all over the place! It's the Human Hamburger!"));
               break;
            case 19:
               AssignCommand(OBJECT_SELF, ActionSpeakString("CHUBBY CHECKER just had a CHICKEN SANDWICH in downtown DULUTH!"));
               break;
            case 20:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Civilization is fun! Anyway, it keeps me busy!!"));
               break;
            case 21:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Clear the laundromat!! This whirl-o-matic just had a nuclear meltdown!!"));
               break;
            case 22:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Concentrate on th'cute, li'l CARTOON GUYS! Remember the SERIAL NUMBERS!! Follow the WHIPPLE AVE. EXIT!! Have a FREE PEPSI!! Turn LEFT at th'HOLIDAY INN!! JOIN the CREDIT WORLD!! MAKE me an OFFER!!!"));
               break;
            case 23:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Disco oil bussing will create a throbbing naugahyde pipeline running straight to the tropics from the rug producing regions and devalue the dollar!"));
               break;
            case 24:
               AssignCommand(OBJECT_SELF, ActionSpeakString("WAIT!! Don't go!! I AM Howard Cosell! ... And I DON'T know Polish jokes!!"));
               break;
            case 25:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Don't hit me!! I'm in the Twilight Zone!!!"));
               break;
            case 26:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Don't SANFORIZE me!!"));
               break;
            case 27:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Edwin Meese made me wear CORDOVANS!!"));
               break;
            case 28:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Eisenhower!! Your mimeograph machine upsets my stomach!!"));
               break;
            case 29:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Either CONFESS now or we go to  PEOPLE'S COURT !!"));
               break;
            case 30:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Everybody gets free BORSCHT!"));
               break;
            case 31:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Everybody is going somewhere!! It's probably a garage sale or a disaster Movie!!"));
               break;
            case 32:
               AssignCommand(OBJECT_SELF, ActionSpeakString("FEELINGS are cascading over me!!!"));
               break;
            case 33:
               AssignCommand(OBJECT_SELF, ActionSpeakString("First, I'm going to give you all the ANSWERS to today's test ... So just plug in your SONY WALKMANS and relax!!"));
               break;
            case 34:
               AssignCommand(OBJECT_SELF, ActionSpeakString("FOOLED you! Absorb EGO SHATTERING impulse rays, polyester poltroon!!"));
               break;
            case 35:
               AssignCommand(OBJECT_SELF, ActionSpeakString("for ARTIFICIAL FLAVORING!!"));
               break;
            case 36:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Four thousand different MAGNATES, MOGULS & NABOBS are romping in my gothic solarium!!"));
               break;
            case 37:
               AssignCommand(OBJECT_SELF, ActionSpeakString("FUN is never having to say you're SUSHI!!"));
               break;
            case 38:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Gee, I feel kind of LIGHT in the head now, knowing I can't make my satellite dish PAYMENTS!"));
               break;
            case 39:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Give them RADAR-GUIDED SKEE-BALL LANES and VELVEETA BURRITOS!!"));
               break;
            case 40:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Go on, EMOTE! I was RAISED on thought balloons!!"));
               break;
            case 41:
               AssignCommand(OBJECT_SELF, ActionSpeakString("GOOD-NIGHT, everybody ... Now I have to go administer FIRST-AID to my pet LEISURE SUIT!!"));
               break;
            case 42:
               AssignCommand(OBJECT_SELF, ActionSpeakString("HAIR TONICS, please!!"));
               break;
            case 43:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Half a mind is a terrible thing to waste!"));
               break;
            case 44:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hand me a pair of leather pants and a CASIO keyboard -- I'm living for today!"));
               break;
            case 45:
               AssignCommand(OBJECT_SELF, ActionSpeakString("He probably just wants to take over my CELLS and then EXPLODE inside me like a BARREL of runny CHOPPED LIVER!"));
               break;
            case 46:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Or maybe he'd like to PSYCHOLOGICALLY TERRORISE ME until I have no objection to a RIGHT-WING MILITARY TAKEOVER of my apartment!!"));
               break;
            case 47:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I guess I should call AL PACINO!"));
               break;
            case 48:
               AssignCommand(OBJECT_SELF, ActionSpeakString("HELLO KITTY gang terrorizes town, family STICKERED to death!"));
               break;
            case 49:
               AssignCommand(OBJECT_SELF, ActionSpeakString("HELLO, everybody, I'm a HUMAN!!"));
               break;
            case 50:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hello, GORRY-O!! I'm a GENIUS from HARVARD!!"));
               break;
            case 51:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hello. I know the divorce rate among unmarried Catholic Alaskan females!!"));
               break;
            case 52:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hello.  Just walk along and try NOT to think about your INTESTINES being almost FORTY YARDS LONG!!"));
               break;
            case 53:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Here I am in 53 B.C. and all I want is a dill pickle!!"));
               break;
            case 54:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Here I am in the POSTERIOR OLFACTORY LOBULE but I don't see CARL SAGAN anywhere!!"));
               break;
            case 55:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hey, wait a minute!! I want a divorce!! ... you're not Clint Eastwood!!"));
               break;
            case 56:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hey, waiter! I want a NEW SHIRT and a PONY TAIL with lemon sauce!"));
               break;
            case 57:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Hiccuping & trembling into the WASTE DUMPS of New Jersey like some drunken CABBAGE PATCH DOLL, coughing in line at FIORUCCI'S!!"));
               break;
            case 58:
               AssignCommand(OBJECT_SELF, ActionSpeakString("HOORAY, Ronald!! Now YOU can marry LINDA RONSTADT too!!"));
               break;
            case 59:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I always have fun because I'm out of my mind!!!"));
               break;
            case 60:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I am a traffic light, and Alan Ginzberg kidnapped my laundry in 1927!"));
               break;
            case 61:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I am covered with pure vegetable oil and I am writing a best seller!"));
               break;
            case 62:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I am deeply CONCERNED and I want something GOOD for BREAKFAST!"));
               break;
            case 63:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I appoint you ambassador to Fantasy Island!!!"));
               break;
            case 64:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I brought my BOWLING BALL -- and some DRUGS!!"));
               break;
            case 65:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I can't decide which WRONG TURN to make first!!"));
               break;
            case 66:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I can't decide which WRONG TURN to make first!! I wonder if BOB GUCCIONE has  these problems!"));
               break;
            case 67:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I didn't order any WOO-WOO ... Maybe a YUBBA ... But no WOO-WOO!"));
               break;
            case 68:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I don't know why but, suddenly, I want to discuss declining I.Q. LEVELS with a blue ribbon SENATE SUB-COMMITTEE!"));
               break;
            case 69:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I don't understand the HUMOUR of the THREE STOOGES!!"));
               break;
            case 70:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I feel like a wet parking meter on Darvon!"));
               break;
            case 71:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I feel like I'm in a Toilet Bowl with a thumbtack in my forehead!!"));
               break;
            case 72:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I feel partially hydrogenated!"));
               break;
            case 73:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I guess you guys got BIG MUSCLES from doing too much STUDYING!"));
               break;
            case 74:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I had pancake makeup for brunch!"));
               break;
            case 75:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have a VISION! It's a RANCID double-FISHWICH on an ENRICHED BUN!!"));
               break;
            case 76:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have accepted Provolone into my life!"));
               break;
            case 77:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I have the power to HALT PRODUCTION on all TEENAGE SEX COMEDIES!!"));
               break;
            case 78:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I HAVE to buy a new  DODGE MISER  and two dozen JORDACHE JEANS because my viewscreen is  USER-FRIENDLY !!"));
               break;
            case 79:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I haven't been married in over six years, but we had sexual counseling every day from Oral Roberts!!"));
               break;
            case 80:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I hope something GOOD came in the mail today so I have a REASON to live!!"));
               break;
            case 81:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I hope you millionaires are having fun! I just invested half your life savings in yeast!!"));
               break;
            case 82:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I invented skydiving in 1989!"));
               break;
            case 83:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I joined scientology at a garage sale!!"));
               break;
            case 84:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just forgot my whole philosophy of life!!!"));
               break;
            case 85:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just had a NOSE JOB!!"));
               break;
            case 86:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just had my entire INTESTINAL TRACT coated with TEFLON!"));
               break;
            case 87:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just heard the SEVENTIES were over!! And I was just getting in touch with my LEISURE SUIT!!"));
               break;
            case 88:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just remembered something about a TOAD!"));
               break;
            case 89:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I know how to do SPECIAL EFFECTS!!"));
               break;
            case 90:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I know th'MAMBO!! I have a TWO-TONE CHEMISTRY SET!!"));
               break;
            case 91:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I know things about TROY DONAHUE that can't even be PRINTED!!"));
               break;
            case 92:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I left my WALLET in the BATHROOM!!"));
               break;
            case 93:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I love ROCK 'N ROLL! I memorized the all WORDS to  WIPE-OUT  in 1965!!"));
               break;
            case 94:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I need to discuss BUY-BACK PROVISIONS with at least six studio SLEAZEBALLS!!"));
               break;
            case 95:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I once decorated my apartment entirely in ten foot salad forks!!"));
               break;
            case 96:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I own seven-eighths of all the artists in downtown Burbank!"));
               break;
            case 97:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I represent a sardine!!"));
               break;
            case 98:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I request a weekend in Havana with Phil Silvers!"));
               break;
            case 99:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I selected E5 ... but I didn't hear  Sam the Sham and the Pharoahs !"));
               break;
            case 100:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I smell a RANCID CORN DOG!"));
               break;
            case 101:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I smell like a wet reducing clinic on Columbus Day!"));
               break;
            case 102:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I think I am an overnight sensation right now!!"));
               break;
            case 103:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I think I'll KILL myself by leaping out of this 14th STORY WINDOW while reading ERICA JONG'S poetry!!"));
               break;
            case 104:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I think my career is ruined!"));
               break;
            case 105:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I used to be a FUNDAMENTALIST, but then I heard about the HIGH RADIATION LEVELS and bought an ENCYCLOPEDIA!!"));
               break;
            case 106:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I want a COLOR T.V. and a VIBRATING BED!!!"));
               break;
            case 107:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want a VEGETARIAN BURRITO to go ... with EXTRA MSG!!"));
               break;
            case 108:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want a WESSON OIL lease!!"));
               break;
            case 109:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want another RE-WRITE on my CAESAR SALAD!!"));
               break;
            case 110:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want EARS! I want two ROUND BLACK EARS to make me feel warm 'n secure!!"));
               break;
            case 111:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I want FORTY-TWO TRYNEL FLOATATION SYSTEMS installed within SIX AND A HALF HOURS!!!"));
               break;
            case 112:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want to kill everyone here with a cute colorful Hydrogen Bomb!!"));
               break;
            case 113:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want to perform cranial activities with Tuesday Weld!!"));
               break;
            case 114:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... I want to perform cranial activities with Tuesday Weld!!"));
               break;
            case 115:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want to so HAPPY, the VEINS in my neck STAND OUT!!"));
               break;
            case 116:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want you to MEMORIZE the collected poems of EDNA ST VINCENT MILLAY ... BACKWARDS!!"));
               break;
            case 117:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I was born in a Hostess Cupcake factory before the sexual revolution!"));
               break;
            case 118:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I was making donuts and now I'm on a bus!"));
               break;
            case 119:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I wish I was a sex-starved manicurist found dead in the Bronx!!"));
               break;
            case 120:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I wish I was on a Cincinnati street corner holding a clean dog!"));
               break;
            case 121:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I wonder if BOB GUCCIONE has these problems!"));
               break;
            case 122:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I wonder if I should put myself in ESCROW!!"));
               break;
            case 123:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'd like MY data-base JULIENNED and stir-fried!"));
               break;
            case 124:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'll eat ANYTHING that's BRIGHT BLUE!!"));
               break;
            case 125:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm a GENIUS! I want to dispute sentence structure with SUSAN SONTAG!!"));
               break;
            case 126:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm a nuclear submarine under the polar ice cap and I need a Kleenex!"));
               break;
            case 127:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm also pre-POURED pre-MEDITATED and pre-RAPHAELITE!!"));
               break;
            case 128:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm ANN LANDERS!! I can SHOPLIFT!!"));
               break;
            case 129:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm changing the CHANNEL ... But all I get is commercials for  RONCO MIRACLE BAMBOO STEAMERS !"));
               break;
            case 130:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm continually AMAZED at th'breathtaking effects of WIND EROSION!!"));
               break;
            case 131:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm definitely not in Omaha!"));
               break;
            case 132:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm EMOTIONAL now because I have MERCHANDISING CLOUT!!"));
               break;
            case 133:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm encased in the lining of a pure pork sausage!!"));
               break;
            case 134:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm GLAD I remembered to XEROX all my UNDERSHIRTS!!"));
               break;
            case 135:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm gliding over a NUCLEAR WASTE DUMP near ATLANTA, Georgia!!"));
               break;
            case 136:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having a BIG BANG THEORY!!"));
               break;
            case 137:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having a MID-WEEK CRISIS!"));
               break;
            case 138:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having a tax-deductible experience! I need an energy crunch!!"));
               break;
            case 139:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having an emotional outburst!!"));
               break;
            case 140:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having an EMOTIONAL OUTBURST!!"));
               break;
            case 141:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having fun HITCHHIKING to CINCINNATI or FAR ROCKAWAY!!"));
               break;
            case 142:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm meditating on the FORMALDEHYDE and the ASBESTOS leaking into my PERSONAL SPACE!!"));
               break;
            case 143:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm not an Iranian!! I voted for Dianne Feinstein!!"));
               break;
            case 144:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm pretending that we're all watching PHIL SILVERS instead of RICARDO MONTALBAN!"));
               break;
            case 145:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm rated PG-34!!"));
               break;
            case 146:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm receiving a coded message from EUBIE BLAKE!!"));
               break;
            case 147:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm RELIGIOUS!! I love a man with a HAIRPIECE!! Equip me with MISSILES!!"));
               break;
            case 148:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm reporting for duty as a modern person. I want to do the Latin Hustle now!"));
               break;
            case 149:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm shaving!! I'M SHAVING!!"));
               break;
            case 150:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm using my X-RAY VISION to obtain a rare glimpse of the INNER WORKINGS of this POTATO!!"));
               break;
            case 151:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm wearing PAMPERS!!"));
               break;
            case 152:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm wet!   I'm wild!"));
               break;
            case 153:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm young ... I'm HEALTHY ... I can HIKE THRU CAPT GROGAN'S LUMBAR REGIONS!"));
               break;
            case 154:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I've got an IDEA!! Why don't I STARE at you so HARD, you forget your SOCIAL SECURITY NUMBER!!"));
               break;
            case 155:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I've read SEVEN MILLION books!!"));
               break;
            case 156:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If I am elected no one will ever have to do their laundry again!"));
               break;
            case 157:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If I am elected, the concrete barriers around the WHITE HOUSE will be replaced by tasteful foam replicas of ANN MARGARET!"));
               break;
            case 158:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If I felt any more SOPHISTICATED I would DIE of EMBARRASSMENT!"));
               break;
            case 159:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If I had a Q-TIP, I could prevent th' collapse of NEGOTIATIONS!!"));
               break;
            case 160:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If I pull this SWITCH I'll be RITA HAYWORTH!! Or a SCIENTOLOGIST!"));
               break;
            case 161:
               AssignCommand(OBJECT_SELF, ActionSpeakString("if it GLISTENS, gobble it!!"));
               break;
            case 162:
               AssignCommand(OBJECT_SELF, ActionSpeakString("If our behavior is strict, we do not need fun!"));
               break;
            case 163:
               AssignCommand(OBJECT_SELF, ActionSpeakString("In 1962, you could buy a pair of SHARKSKIN SLACKS, with a  Continental Belt,  for $10.99!!"));
               break;
            case 164:
               AssignCommand(OBJECT_SELF, ActionSpeakString("In Newark the laundromats are open 24 hours a day!"));
               break;
            case 165:
               AssignCommand(OBJECT_SELF, ActionSpeakString("INSIDE, I have the same personality disorder as LUCY RICARDO!!"));
               break;
            case 166:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Inside, I'm already SOBBING!"));
               break;
            case 167:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It don't mean a THING if you ain't got that SWING!!"));
               break;
            case 168:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It's NO USE ... I've gone to  CLUB MED !!"));
               break;
            case 169:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It's OBVIOUS ... The FURS never reached ISTANBUL ... You were an EXTRA in the REMAKE of  TOPKAPI  ... Go home to your WIFE ... She's making FRENCH TOAST!"));
               break;
            case 170:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It's the RINSE CYCLE!! They've ALL IGNORED the RINSE CYCLE!!"));
               break;
            case 171:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Jesuit priests are DATING CAREER DIPLOMATS!!"));
               break;
            case 172:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Kids, don't gross me off ...  Adventures with MENTAL HYGIENE  can be carried too FAR!"));
               break;
            case 173:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Kids, the seven basic food groups are GUM, PUFF PASTRY, PIZZA, PESTICIDES, ANTIBIOTICS, NUTRA-SWEET and MILK DUDS!!"));
               break;
            case 174:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Laundry is the fifth dimension!! ... um ... um ... th' washing machine is a black hole and the pink socks are bus drivers who just fell in!!"));
               break;
            case 175:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Let's all show human CONCERN for REVEREND MOON's legal difficulties!!"));
               break;
            case 176:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Let's send the Russians defective lifestyle accessories!"));
               break;
            case 177:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Life is a POPULARITY CONTEST! I'm REFRESHINGLY CANDID!!"));
               break;
            case 178:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Like I always say -- nothing can beat the BRATWURST here in DUSSELDORF!!"));
               break;
            case 179:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Loni Anderson's hair should be LEGALIZED!!"));
               break;
            case 180:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Look into my eyes and try to forget that you have a Macy's charge card!"));
               break;
            case 181:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Look! A ladder! Maybe it leads to heaven, or a sandwich!"));
               break;
            case 182:
               AssignCommand(OBJECT_SELF, ActionSpeakString("LOOK!! Sullen American teens wearing MADRAS shorts and  Flock of Seagulls  HAIRCUTS!"));
               break;
            case 183:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Make me look like LINDA RONSTADT again!!"));
               break;
            case 184:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Mary Tyler Moore's SEVENTH HUSBAND is wearing my DACRON TANK TOP in a cheap hotel in HONOLULU!"));
               break;
            case 185:
               AssignCommand(OBJECT_SELF, ActionSpeakString("MERYL STREEP is my obstetrician!"));
               break;
            case 186:
               AssignCommand(OBJECT_SELF, ActionSpeakString("MMM-MM!! So THIS is BIO-NEBULATION!"));
               break;
            case 187:
               AssignCommand(OBJECT_SELF, ActionSpeakString("YUM!! That was GOOD!! For DESSERT, I'll have a TOFU BURGER with BEAN SPROUTS on a stone-ground, WHOLE WHEAT BUN!!"));
               break;
            case 188:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My Aunt MAUREEN was a military advisor to IKE & TINA TURNER!!"));
               break;
            case 189:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My BIOLOGICAL ALARM CLOCK just went off ... It has noiseless DOZE FUNCTION and full kitchen!!"));
               break;
            case 190:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My CODE of ETHICS is vacationing at famed SCHROON LAKE in upstate New York!!"));
               break;
            case 191:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My EARS are GONE!!"));
               break;
            case 192:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My face is new, my license is expired, and I'm under a doctor's care!!!!"));
               break;
            case 193:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My haircut is totally traditional!"));
               break;
            case 194:
               AssignCommand(OBJECT_SELF, ActionSpeakString("MY income is ALL disposable!"));
               break;
            case 195:
               AssignCommand(OBJECT_SELF, ActionSpeakString("my NOSE is NUMB!"));
               break;
            case 196:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... My pants just went on a wild rampage through a Long Island Bowling Alley!!"));
               break;
            case 197:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My pants just went to  high school in the Carlsbad Caverns!!!"));
               break;
            case 198:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My polyvinyl cowboy wallet was made in Hong Kong by Montgomery Clift!"));
               break;
            case 199:
               AssignCommand(OBJECT_SELF, ActionSpeakString("My uncle Murray conquered Egypt in 53 B.C.  And I can prove it too!!"));
               break;
            case 200:
               AssignCommand(OBJECT_SELF, ActionSpeakString("NEWARK has been REZONED!! DES MOINES has been REZONED!!"));
               break;
            case 201:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Nipples, dimples, knuckles, NICKLES, wrinkles, pimples!!"));
               break;
            case 202:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Not SENSUOUS ... only  FROLICSOME  ... and in need of DENTAL WORK ... in PAIN!!!"));
               break;
            case 203:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I think I just reached the state of HYPERTENSION that comes JUST BEFORE you see the TOTAL at the SAFEWAY CHECKOUT COUNTER!"));
               break;
            case 204:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I understand the meaning of  THE MOD SQUAD !"));
               break;
            case 205:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I'm being INVOLUNTARILY shuffled closer to the CLAM DIP with the BROKEN PLASTIC FORKS in it!!"));
               break;
            case 206:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I'm concentrating on a specific tank battle toward the end of World War II!"));
               break;
            case 207:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now my EMOTIONAL RESOURCES are heavily committed to 23% of the SMELTING and REFINING industry of the state of NEVADA!!"));
               break;
            case 208:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now that I have my  APPLE , I comprehend COST ACCOUNTING!!"));
               break;
            case 209:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... Now, it's time to  HAVE A NAGEELA !!"));
               break;
            case 210:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now, let's SEND OUT for QUICHE!!"));
               break;
            case 211:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Oh my GOD -- the SUN just fell into YANKEE STADIUM!!"));
               break;
            case 212:
               AssignCommand(OBJECT_SELF, ActionSpeakString("OKAY!! Turn on the sound ONLY for TRYNEL CARPETING, FULLY-EQUIPPED R.V.'S and FLOATATION SYSTEMS!!"));
               break;
            case 213:
               AssignCommand(OBJECT_SELF, ActionSpeakString("On SECOND thought, maybe I'll heat up some BAKED BEANS and watch REGIS PHILBIN ... It's GREAT to be ALIVE!!"));
               break;
            case 214:
               AssignCommand(OBJECT_SELF, ActionSpeakString("On the other hand, life can be an endless parade of TRANSSEXUAL QUILTING BEES aboard a cruise ship to DISNEYWORLD if only we let it!!"));
               break;
            case 215:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Once upon a time, four AMPHIBIOUS HOG CALLERS attacked a family of DEFENSELESS, SENSITIVE COIN COLLECTORS and brought DOWN their PROPERTY VALUES!!"));
               break;
            case 216:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Then, in 1985 ... FUN was completely encoded in this tiny MICROCHIP ... It contain 14,768 vaguely amusing SIT-COM pilots!!"));
               break;
            case 217:
               AssignCommand(OBJECT_SELF, ActionSpeakString("We had to wait FOUR BILLION years but we finally got JERRY LEWIS, MTV and a large selection of creme-filled snack cakes!"));
               break;
            case 218:
               AssignCommand(OBJECT_SELF, ActionSpeakString("One FISHWICH coming up!!"));
               break;
            case 219:
               AssignCommand(OBJECT_SELF, ActionSpeakString("THREE: I won't ever TUMBLE DRY my FOX TERRIER again!!"));
               break;
            case 220:
               AssignCommand(OBJECT_SELF, ActionSpeakString("OVER the underpass! UNDER the overpass! Around the FUTURE and BEYOND REPAIR!!"));
               break;
            case 221:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Pardon me, but do you know what it means to be TRULY ONE with your BOOTH!"));
               break;
            case 222:
               AssignCommand(OBJECT_SELF, ActionSpeakString("PIZZA!!"));
               break;
            case 223:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Place me on a BUFFER counter while you BELITTLE several BELLHOPS in the Trianon Room!! Let me one of your SUBSIDIARIES!"));
               break;
            case 224:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Please come home with me ... I have Tylenol!!"));
               break;
            case 225:
               AssignCommand(OBJECT_SELF, ActionSpeakString("PUNK ROCK!! DISCO DUCK!! BIRTH CONTROL!!"));
               break;
            case 226:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Quick, sing me the BUDAPEST NATIONAL ANTHEM!!"));
               break;
            case 227:
               AssignCommand(OBJECT_SELF, ActionSpeakString("RELATIVES!!"));
               break;
            case 228:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Remember, in 2039, MOUSSE & PASTA will be available ONLY by prescription!!"));
               break;
            case 229:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Remote keyless entry, remote keyless entry, remote keyless entry!"));
               break;
            case 230:
               AssignCommand(OBJECT_SELF, ActionSpeakString("RHAPSODY in Glue!"));
               break;
            case 231:
               AssignCommand(OBJECT_SELF, ActionSpeakString("So, if we convert SUPPLY-SIDE SOYABEAN FUTURES into HIGH-YIELD T-BILL INDICATORS, the PRE-INFLATIONARY risks will DWINDLE to a rate of 2 SHOPPING SPREES per EGGPLANT!!"));
               break;
            case 232:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Sometime in 1993 NANCY SINATRA will lead a BLOODLESS COUP on GUAM!!"));
               break;
            case 233:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Somewhere in DOWNTOWN BURBANK a prostitute is OVERCOOKING a LAMB CHOP!!"));
               break;
            case 234:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Somewhere in suburban Honolulu, an unemployed bellhop is whipping up a batch of illegal psilocybin chop suey!!"));
               break;
            case 235:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Somewhere in Tenafly, New Jersey, a chiropractor is viewing  Leave it to Beaver !"));
               break;
            case 236:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Oh, I LOST my ``HELLO KITTY'' DOLL and I get BAD reception on channel TWENTY-SIX!!"));
               break;
            case 237:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Tex SEX! The HOME of WHEELS! The dripping of COFFEE!! Take me to Minnesota but don't EMBARRASS me!!"));
               break;
            case 238:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Thank god!! ... It's HENNY YOUNGMAN!!"));
               break;
            case 239:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The appreciation of the average visual graphisticator alone is worth the whole suaveness and decadence which abounds!!"));
               break;
            case 240:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The entire CHINESE WOMEN'S VOLLEYBALL TEAM all share ONE personality -- and have since BIRTH!!"));
               break;
            case 241:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The fact that 47 PEOPLE are yelling and sweat is cascading down my SPINAL COLUMN is fairly enjoyable!!"));
               break;
            case 242:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... the HIGHWAY is made out of LIME JELLO and my HONDA  is a barbequeued OYSTER! Yum!"));
               break;
            case 243:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... the MYSTERIANS are in here with my CORDUROY SOAP DISH!!"));
               break;
            case 244:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The Osmonds! You are all Osmonds!! Throwing up on a freeway at dawn!!!"));
               break;
            case 245:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The PILLSBURY DOUGHBOY is CRYING for an END to BURT REYNOLDS movies!!"));
               break;
            case 246:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The PINK SOCKS were ORIGINALLY from 1952!! But they went to MARS around 1953!!"));
               break;
            case 247:
               AssignCommand(OBJECT_SELF, ActionSpeakString("There's a little picture of ED MCMAHON doing BAD THINGS to JOAN RIVERS in a $200,000 MALIBU BEACH HOUSE!!"));
               break;
            case 248:
               AssignCommand(OBJECT_SELF, ActionSpeakString("There's enough money here to buy 5000 cans of Noodle-Roni!"));
               break;
            case 249:
               AssignCommand(OBJECT_SELF, ActionSpeakString("These PRESERVES should be FORCE-FED to PENTAGON OFFICIALS!!"));
               break;
            case 250:
               AssignCommand(OBJECT_SELF, ActionSpeakString("They collapsed ... like nuns in the street ... they had no teen appeal!"));
               break;
            case 251:
               AssignCommand(OBJECT_SELF, ActionSpeakString("This ASEXUAL PIG really BOILS my BLOOD ... He's so ... so ... URGENT!!"));
               break;
            case 252:
               AssignCommand(OBJECT_SELF, ActionSpeakString("This is a NO-FRILLS flight -- hold th' CANADIAN BACON!!"));
               break;
            case 253:
               AssignCommand(OBJECT_SELF, ActionSpeakString("This MUST be a good party -- My RIB CAGE is being painfully pressed up against someone's MARTINI!!"));
               break;
            case 254:
               AssignCommand(OBJECT_SELF, ActionSpeakString("... this must be what it's like to be a COLLEGE GRADUATE!!"));
               break;
            case 255:
               AssignCommand(OBJECT_SELF, ActionSpeakString("This PIZZA symbolizes my COMPLETE EMOTIONAL RECOVERY!!"));
               break;
            case 256:
               AssignCommand(OBJECT_SELF, ActionSpeakString("This PORCUPINE knows his ZIPCODE ... And he has  VISA !!"));
               break;
            case 257:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Those aren't WINOS -- that's my JUGGLER, my AERIALIST, my SWORD SWALLOWER, and my LATEX NOVELTY SUPPLIER!!"));
               break;
            case 258:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Today, THREE WINOS from DETROIT sold me a framed photo of TAB HUNTER before his MAKEOVER!"));
               break;
            case 259:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Toes, knees, NIPPLES.  Toes, knees, nipples, KNUCKLES ... Nipples, dimples, knuckles, NICKLES, wrinkles, pimples!!"));
               break;
            case 260:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Uh-oh!! I forgot to submit to COMPULSORY URINALYSIS!"));
               break;
            case 261:
               AssignCommand(OBJECT_SELF, ActionSpeakString("UH-OH!! I put on  GREAT HEAD-ON TRAIN COLLISIONS of the 50's  by mistake!!!"));
               break;
            case 262:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Uh-oh!!  I'm having TOO MUCH FUN!!"));
               break;
            case 263:
               AssignCommand(OBJECT_SELF, ActionSpeakString("UH-OH!! We're out of AUTOMOBILE PARTS and RUBBER GOODS!"));
               break;
            case 264:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Used staples are good with SOY SAUCE!"));
               break;
            case 265:
               AssignCommand(OBJECT_SELF, ActionSpeakString("VICARIOUSLY experience some reason to LIVE!!"));
               break;
            case 266:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Vote for ME -- I'm well-tapered, half-cocked, ill-conceived and TAX-DEFERRED!"));
               break;
            case 267:
               AssignCommand(OBJECT_SELF, ActionSpeakString("We just joined the civil hair patrol!"));
               break;
            case 268:
               AssignCommand(OBJECT_SELF, ActionSpeakString("We place two copies of PEOPLE magazine in a DARK, HUMID mobile home. 45 minutes later CYNDI LAUPER emerges wearing a BIRD CAGE on her head!"));
               break;
            case 269:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Well, I'm a classic ANAL RETENTIVE!! And I'm looking for a way to VICARIOUSLY experience some reason to LIVE!!"));
               break;
            case 270:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Well, O.K. I'll compromise with my principles because of EXISTENTIAL DESPAIR!"));
               break;
            case 271:
               AssignCommand(OBJECT_SELF, ActionSpeakString("What a COINCIDENCE! I'm an authorized  SNOOTS OF THE STARS  dealer!!"));
               break;
            case 272:
               AssignCommand(OBJECT_SELF, ActionSpeakString("While my BRAINPAN is being refused service in BURGER KING, Jesuit priests are DATING CAREER DIPLOMATS!!"));
               break;
            case 273:
               AssignCommand(OBJECT_SELF, ActionSpeakString("While you're chewing, think of STEVEN SPIELBERG'S bank account ... his will have the same effect as two  STARCH BLOCKERS !"));
               break;
            case 274:
               AssignCommand(OBJECT_SELF, ActionSpeakString("WHOA!! Ken and Barbie are having TOO MUCH FUN!! It must be the NEGATIVE IONS!!"));
               break;
            case 275:
               AssignCommand(OBJECT_SELF, ActionSpeakString("World War Three can be averted by adherence to a strictly enforced dress code!"));
               break;
            case 276:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Wow! Look!! A stray meatball!! Let's interview it!"));
               break;
            case 277:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Xerox your lunch and file it under  sex offenders !"));
               break;
            case 278:
               AssignCommand(OBJECT_SELF, ActionSpeakString("You can't hurt me!! I have an ASSUMABLE MORTGAGE!!"));
               break;
            case 279:
               AssignCommand(OBJECT_SELF, ActionSpeakString("YOU PICKED KARL MALDEN'S NOSE!!"));
               break;
            case 280:
               AssignCommand(OBJECT_SELF, ActionSpeakString("You should all JUMP UP AND DOWN for TWO HOURS while I decide on a NEW CAREER!!"));
               break;
            case 281:
               AssignCommand(OBJECT_SELF, ActionSpeakString("You were s'posed to laugh!"));
               break;
            case 282:
               AssignCommand(OBJECT_SELF, ActionSpeakString("YOU!! Give me the CUTEST, PINKEST, most charming little VICTORIAN DOLLHOUSE you can find!! An make it SNAPPY!!"));
               break;
            case 283:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Youth of today!  Join me in a mass rally for traditional mental attitudes!"));
               break;
            case 284:
               AssignCommand(OBJECT_SELF, ActionSpeakString("And then we could sit on the hoods of cars at stop lights!"));
               break;
            case 285:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I just went below the poverty line!"));
               break;
            case 286:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I threw up on my window!"));
               break;
            case 287:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want my nose in lights!"));
               break;
            case 288:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I want to mail a bronzed artichoke to Nicaragua!"));
               break;
            case 289:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm having a quadrophonic sensation of two winos alone in a steel mill!"));
               break;
            case 290:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm imagining a surfer van filled with soy sauce!"));
               break;
            case 291:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It's a hole all the way to downtown Burbank!"));
               break;
            case 292:
               AssignCommand(OBJECT_SELF, ActionSpeakString("It's some people inside the wall! This is better than mopping!"));
               break;
            case 293:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I get to think about all the BAD THINGS I did to a BOWLING BALL when I was in JUNIOR HIGH SCHOOL!"));
               break;
            case 294:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now we can become alcoholics!"));
               break;
            case 295:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Those people look exactly like Donnie and Marie Osmond!!"));
               break;
            case 296:
               AssignCommand(OBJECT_SELF, ActionSpeakString("We're going to a new disco!"));
               break;
            case 297:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Everybody out of the GENETIC POOL!"));
               break;
            case 298:
               AssignCommand(OBJECT_SELF, ActionSpeakString("I'm in a very clever and adorable INSANE ASYLUM!!"));
               break;
            case 299:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Now I understand advanced MICROBIOLOGY and th' new TAX REFORM laws!!"));
               break;
            case 300:
               AssignCommand(OBJECT_SELF, ActionSpeakString("The land of the rising SONY!!"));
               break;
            case 301:
               AssignCommand(OBJECT_SELF, ActionSpeakString("Up ahead!    It's a DONUT HUT!!"));
               break;
      }
}
