-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
   target:addMod(tpz.mod.SLEEPRESTRAIT,200)
   target:addMod(tpz.mod.POISONRESTRAIT,200)
   target:addMod(tpz.mod.PARALYZERESTRAIT,200)
   target:addMod(tpz.mod.BLINDRESTRAIT,200)
   target:addMod(tpz.mod.SILENCERESTRAIT,200)
   target:addMod(tpz.mod.VIRUSRESTRAIT,200)
   target:addMod(tpz.mod.PETRIFYRESTRAIT,200)
   target:addMod(tpz.mod.BINDRESTRAIT,200)
   target:addMod(tpz.mod.CURSERESTRAIT,200)
   target:addMod(tpz.mod.GRAVITYRESTRAIT,200)
   target:addMod(tpz.mod.SLOWRESTRAIT,200)
   target:addMod(tpz.mod.STUNRESTRAIT,200)
   target:addMod(tpz.mod.CHARMRESTRAIT,200)
   target:addMod(tpz.mod.AMNESIARESTRAIT,200)
   target:addMod(tpz.mod.LULLABYRESTRAIT,200)
end

function onEffectTick(target,effect)
end

function onEffectLose(target,effect)
   target:delMod(tpz.mod.SLEEPRESTRAIT,200)
   target:delMod(tpz.mod.POISONRESTRAIT,200)
   target:delMod(tpz.mod.PARALYZERESTRAIT,200)
   target:delMod(tpz.mod.BLINDRESTRAIT,200)
   target:delMod(tpz.mod.SILENCERESTRAIT,200)
   target:delMod(tpz.mod.VIRUSRESTRAIT,200)
   target:delMod(tpz.mod.PETRIFYRESTRAIT,200)
   target:delMod(tpz.mod.BINDRESTRAIT,200)
   target:delMod(tpz.mod.CURSERESTRAIT,200)
   target:delMod(tpz.mod.GRAVITYRESTRAIT,200)
   target:delMod(tpz.mod.SLOWRESTRAIT,200)
   target:delMod(tpz.mod.STUNRESTRAIT,200)
   target:delMod(tpz.mod.CHARMRESTRAIT,200)
   target:delMod(tpz.mod.AMNESIARESTRAIT,200)
   target:delMod(tpz.mod.LULLABYRESTRAIT,200)
end
