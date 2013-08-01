/*
* Copyright (C) 2012-2013 HTCore <http://cata.vfire-core.com/>
* Copyright (C) 2012-2013 WoW Source <http://wow.amgi-it.ro/>
* by Shee Shen
*/

#include"ScriptPCH.h"
#include"halls_of_origination.h"

enum ScriptTexts
{
    SAY_AGGRO = 0,
    SAY_BEACON = 1,
    SAY_KILL_1 = 2,
    SAY_KILL_2 = 3,
    SAY_DEATH = 4,
    SAY_ANNOUNCE = 5,
};

enum Spells
{
    SPELL_DIVINE_RECKONING = 75592,
    SPELL_REVERBERATING_HYMN = 75322,
    SPELL_SHIELD_OF_LIGHT = 74938,
    SPELL_SEARING_FLAME_SUMM = 75114,
    // Lever beams.
    SPELL_BEAM_LEFT = 83697, // Object 203133
    SPELL_BEAM_RIGHT = 83698, // Object 203136
};

enum
{
	NPC_PIT_SNAKE = 39444,
	GO_ANHUUR_BRIDGE = 206506,
};

const Position aSpawnLocations[21] =
{
    {-654.277f, 361.118f, 52.9508f, 5.86241f},
    {-670.102f, 350.896f, 54.1803f, 2.53073f},
    {-668.896f, 326.048f, 53.2267f, 3.36574f},
    {-618.875f, 344.237f, 52.95f, 0.194356f},
    {-661.667f, 338.78f, 53.0333f, 2.53073f},
    {-607.836f, 348.586f, 53.4939f, 1.0558f},
    {-656.452f, 376.388f, 53.9709f, 1.4525f},
    {-652.762f, 370.634f, 52.9503f, 2.5221f},
    {-682.656f, 343.953f, 53.7329f, 2.53073f},
    {-658.877f, 309.077f, 53.6711f, 0.595064f},
    {-619.399f, 309.049f, 53.4247f, 4.63496f},
    {-612.648f, 318.365f, 53.777f, 3.53434f},
    {-616.398f, 345.109f, 53.0165f, 2.53073f},
    {-681.394f, 342.813f, 53.8955f, 6.24987f},
    {-668.843f, 351.407f, 54.1813f, 5.5293f},
    {-672.797f, 317.175f, 52.9636f, 5.51166f},
    {-631.834f, 375.502f, 55.7079f, 0.738231f},
    {-617.027f, 360.071f, 52.9816f, 2.00725f},
    {-623.891f, 361.178f, 52.9334f, 5.61183f},
    {-614.988f, 331.613f, 52.9533f, 2.91186f},
    {-662.902f, 341.463f, 52.9502f, 2.84307f}
};

const float centerPos[4] =
    {-640.527f, 334.855f, 78.345f, 1.54f};

enum BossPhases
{
    PHASE_NORMAL = 1,
    PHASE_SHIELD = 2,
};

enum Events
{
    EVENT_FLAMES,
    EVENT_REKOCKING,
};

/******************
** Guardian Anhuur
******************/
class boss_temple_guardian_anhuur : public CreatureScript
{
    public:
        boss_temple_guardian_anhuur() : CreatureScript("boss_temple_guardian_anhuur") { }

        struct boss_temple_guardian_anhuurAI : public BossAI
        {
            boss_temple_guardian_anhuurAI(Creature* creature) : BossAI(creature, DATA_TEMPLE_GUARDIAN_ANHUUR)
            {
                instance = creature->GetInstanceScript();
            }

            std::list<uint64> SummonList;

            InstanceScript *instance;
            EventMap events;

            uint8 Phase;
            uint8 PhaseCount;
            uint8 FlameCount;

            void Reset()
            {
                _Reset();
                instance->SetData(DATA_TEMPLE_GUARDIAN_ANHUUR, NOT_STARTED);
                Phase = PHASE_NORMAL;
                PhaseCount = 0;
                FlameCount = 2;
                RemoveSummons();
                me->RemoveAurasDueToSpell(SPELL_SHIELD_OF_LIGHT);
                me->RemoveAurasDueToSpell(SPELL_DIVINE_RECKONING);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_SET_COMBAT_RES_LIMIT, me);
            }

            void RemoveSummons()
            {
                if (SummonList.empty())
                    return;

                for (std::list<uint64>::const_iterator itr = SummonList.begin(); itr != SummonList.end(); ++itr)
                {
                    if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                        if (pTemp)
                            pTemp->DisappearAndDie();
                }
                SummonList.clear();
            }

            void JustSummoned(Creature* pSummon)
            {
                SummonList.push_back(pSummon->GetGUID());
            }

            void ChangePhase()
            {
                DoTeleportTo(centerPos);
                me->SetOrientation(1.54f);
                for(uint32 x = 0; x<21; ++x)
                   me->SummonCreature(NPC_PIT_SNAKE, aSpawnLocations[x].GetPositionX(), aSpawnLocations[x].GetPositionY(), aSpawnLocations[x].GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);

                Talk(SAY_BEACON);
                Talk(SAY_ANNOUNCE);
                PhaseCount++;
                Phase = PHASE_SHIELD;
				DoCast(me, SPELL_SHIELD_OF_LIGHT);
				me->AddAura(74938, me);

                if (Creature *light1 = me->SummonCreature(40183, -603.465f, 334.38f, 65.4f, 3.12f,TEMPSUMMON_CORPSE_DESPAWN, 1000))
                    light1->CastSpell(me, SPELL_BEAM_LEFT, false);

                if (Creature *light2 = me->SummonCreature(40183, -678.132f, 334.212f, 64.9f, 0.24f,TEMPSUMMON_CORPSE_DESPAWN, 1000))
                    light2->CastSpell(me, SPELL_BEAM_RIGHT, false);
            }

            void KilledUnit(Unit* /*Killed*/)
            {
                Talk(RAND(SAY_KILL_1, SAY_KILL_2));
            }

            void JustDied(Unit* /*Kill*/)
            {
                RemoveSummons();
                Talk(SAY_DEATH);
                instance->SetData(DATA_TEMPLE_GUARDIAN_ANHUUR, DONE);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_SET_COMBAT_RES_LIMIT, me);

                GameObject* Bridge = me->FindNearestGameObject(GO_ANHUUR_BRIDGE, 200);
                if (Bridge)
                    Bridge->SetGoState(GO_STATE_ACTIVE);
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                switch(summon->GetEntry())
                {
                    case 40183:
                        FlameCount--;
                        break;
                }
            }

            void EnterCombat(Unit* /*Ent*/)
            {
                Talk(SAY_AGGRO);
                instance->SetData(DATA_TEMPLE_GUARDIAN_ANHUUR, IN_PROGRESS);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_RESET_COMBAT_RES_LIMIT, me);

                events.ScheduleEvent(EVENT_REKOCKING, 8000);
                events.ScheduleEvent(EVENT_FLAMES, 5000);
                DoZoneInCombat();
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() && !me->HasAura(SPELL_SHIELD_OF_LIGHT))
                    return;

                if ((me->HealthBelowPct(34) && Phase == PHASE_NORMAL && PhaseCount == 1) ||
                    (me->HealthBelowPct(67) && Phase == PHASE_NORMAL && PhaseCount == 0))
                {
                    ChangePhase();
                }

                if (Phase == PHASE_SHIELD && FlameCount == 0)
                {
                    me->RemoveAurasDueToSpell(SPELL_SHIELD_OF_LIGHT);
                    FlameCount = 2;
                }

                if (!me->HasUnitState(UNIT_STATE_CASTING) && Phase == PHASE_SHIELD)
                {
                    Phase = PHASE_NORMAL;
                    RemoveSummons();
                }

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_REKOCKING:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                DoCast(target, SPELL_DIVINE_RECKONING);
                            events.ScheduleEvent(EVENT_REKOCKING, urand(15000, 18000));
                            break;
                        case EVENT_FLAMES:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                target->CastSpell(target, SPELL_SEARING_FLAME_SUMM, true);
                            events.ScheduleEvent(EVENT_FLAMES, 8000);
                            break;
                    }
                }
                DoMeleeAttackIfReady();
            }
        };
        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_temple_guardian_anhuurAI(creature);
        }
};

/********************
** Vip�re de la Fosse
*********************/
#define spell_crochet 74538
class mob_viper: public CreatureScript
{
public: 
 mob_viper() : CreatureScript("mob_viper") { } 

 struct mob_viperAI : public ScriptedAI
    {
        mob_viperAI(Creature *c) : ScriptedAI(c) {}

		uint32 crochet;
		
        void Reset()
        {
           crochet = 15000;     
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
            return;

            if (crochet<= diff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                DoCast(pTarget, spell_crochet);
                crochet   = 15000; 
            } else crochet -= diff; 

			DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_viperAI (pCreature);
    }

};

/********************
** Pilier de lumi�re
*********************/
class go_beacon_of_light : public GameObjectScript
{
public:
    go_beacon_of_light() : GameObjectScript("go_beacon_of_light") { }

    bool OnGossipHello(Player* pPlayer, GameObject* pGO)
    {
        pPlayer->CastSpell(pGO, 68398, false);

        if (Creature* beam = pGO->FindNearestCreature(40183, 14.0f, true))
            beam->Kill(beam);

        return true;
    }
};

void AddSC_boss_temple_guardian_anhuur()
{
    new boss_temple_guardian_anhuur();
    new go_beacon_of_light();
    new mob_viper();
}