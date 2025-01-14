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

local Move =
{
	Properties =
	{
		Speed = 4.0
	}
}

function Move:OnActivate()
	self.direction = 0.0
	
	self.tickHandler = TickBus.Connect(self)
	self.inputHandler = InputEventNotificationBus.Connect(self, InputEventNotificationId("Move"))
end

function Move:OnPressed(value)
	self.direction = value
end

function Move:OnReleased()
	self.direction = 0.0
end

function Move:OnTick(deltaTime, time)
	local velocity = Vector3(0.0, self.direction * self.Properties.Speed, 0.0)
	CharacterControllerRequestBus.Event.AddVelocityForTick(self.entityId, velocity)
end

function Move:OnDeactivate()
	self.inputHandler:Disconnect()
	self.tickHandler:Disconnect()
end

return Move
