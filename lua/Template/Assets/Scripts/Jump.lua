-- Copyright (c) 2025 Matteo Grasso
-- 
--     https://github.com/matteogrs/templates.o3de.minimal.platformer
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

local Jump =
{
	Properties =
	{
		Strength = 5.0
	}
}

function Jump:OnActivate()
	self.jump = false

	self.tickHandler = TickBus.Connect(self)
	self.inputHandler = InputEventNotificationBus.Connect(self, InputEventNotificationId("Jump"))
end

function Jump:OnPressed(value)
	if not self.jump then
		self.jump = true
		self:AddJumpVelocity()
	end
end

function Jump:OnTick(deltaTime, time)
	if self.jump then
		if CharacterGameplayRequestBus.Event.IsOnGround(self.entityId) then
			self.jump = false
		else
			self:AddJumpVelocity()
		end
	end
end

function Jump:AddJumpVelocity()
	local velocity = Vector3(0.0, 0.0, self.Properties.Strength)
	CharacterControllerRequestBus.Event.AddVelocityForTick(self.entityId, velocity)
end

function Jump:OnDeactivate()
	self.inputHandler:Disconnect()
	self.tickHandler:Disconnect()
end

return Jump
