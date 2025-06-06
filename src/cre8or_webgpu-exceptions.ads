------------------------------------------------------------------------------------------------------------------------
--  Copyright 2024 Cre8or                                                                                             --
--                                                                                                                    --
--  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance    --
--  with the License. You may obtain a copy of the License at                                                         --
--                                                                                                                    --
--     http://www.apache.org/licenses/LICENSE-2.0                                                                     --
--                                                                                                                    --
--  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed  --
--  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                     --
--  See the License for the specific language governing permissions and limitations under the License.                --
------------------------------------------------------------------------------------------------------------------------





package Cre8or_WebGPU.Exceptions is



	-- Pragmas
	pragma Preelaborate;



	-- Exceptions
	EX_NOT_YET_IMPLEMENTED : exception;

	EX_REQUEST_ERROR                   : exception;
	EX_INSTANCE_NOT_INITIALISED        : exception;
	EX_ADAPTER_NOT_INITIALISED         : exception;
	EX_DEVICE_NOT_INITIALISED          : exception;
	EX_QUEUE_NOT_INITIALISED           : exception;
	EX_SURFACE_NOT_INITIALISED         : exception;
	EX_COMMAND_BUFFER_NOT_INITIALISED  : exception;
	EX_COMMAND_ENCODER_NOT_INITIALISED : exception;



end Cre8or_WebGPU.Exceptions;
