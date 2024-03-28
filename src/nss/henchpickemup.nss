//Contributed by Mike Daneman aka. Mishenka
//Modified: 69MEH69 Added more items to pick up
#include "69_inc_henai"

void main()
{
    object oMaster = GetRealMaster();
    ClearAllActions();
    SetAssociateState(NW_ASC_IS_BUSY);
    int bFound = FALSE;
    string sName;
    location lCenter = GetLocation(OBJECT_SELF);
    object oThing = GetFirstObjectInShape(SHAPE_SPHERE,10.0,lCenter,TRUE,OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM);
    while(GetIsObjectValid(oThing))
    {
        if(GetObjectType(oThing)==OBJECT_TYPE_ITEM)
        {
            bFound = TRUE;
            /*switch(GetBaseItemType(oThing)) {
                case BASE_ITEM_POTIONS:
                case BASE_ITEM_HEALERSKIT:
                case BASE_ITEM_SPELLSCROLL:
                case BASE_ITEM_ARMOR:*/
                    sName = GetName(oThing);
                    ActionPickUpItem(oThing);
                    ActionDoCommand(SendMessageToPC(oMaster,GetName(OBJECT_SELF)+" picked up "+sName+"."));
                    /*break;

                default:
                    break;
            }*/
        }
        else // oThing is a placeable
        {
            if(GetHasInventory(oThing)) // Containers (including corpses)
            {
                // Don't search locked containers
                // Only search trapped containers if you can't see the trap
                if(!GetLocked(oThing) && (!GetIsTrapped(oThing)
                    || (GetIsTrapped(oThing) && !GetTrapDetectedBy(oThing,OBJECT_SELF))))
                {
                    bFound = TRUE;
                    ActionMoveToObject(oThing);
                    ActionDoCommand(AssignCommand(oThing,PlayAnimation(ANIMATION_PLACEABLE_OPEN)));
                    //ActionInteractObject(oThing);
                    //ActionDoCommand(DoPlaceableObjectAction(oThing,PLACEABLE_ACTION_USE));
                    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);
                    object oItem = GetFirstItemInInventory(oThing);
                    while(GetIsObjectValid(oItem))
                    {
                       /* switch(GetBaseItemType(oItem)) {
                            case BASE_ITEM_POTIONS:
                            case BASE_ITEM_HEALERSKIT:
                            case BASE_ITEM_SPELLSCROLL:
                            case BASE_ITEM_ARMOR:*/
                                ActionDoCommand(SendMessageToPC(oMaster,GetName(OBJECT_SELF)+" picked up "+GetName(oItem)+" from "+GetName(oThing)+"."));
                                ActionTakeItem(oItem,oThing);
                             /*   break;
                            default:
                                break;
                        }*/
                        oItem = GetNextItemInInventory(oThing);
                    }
                    ActionDoCommand(AssignCommand(oThing,PlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
                }
            }
        } // else
        oThing = GetNextObjectInShape(SHAPE_SPHERE,10.0,lCenter,TRUE,OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM);
    } // while(GetIsObjectValid(oThing))
    ActionDoCommand(SetAssociateState(NW_ASC_IS_BUSY,FALSE));
    if(!bFound)
        SpeakString("I don't see where I can find any around here.");
}


