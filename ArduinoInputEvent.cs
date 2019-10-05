using System;

namespace Iot.Events
{
	[Serializable]
	public class ArduinoInputEvent : EventBase
	{
		#region Properties
		public Guid DeviceId
		{
			get;
			set;
		}
		public ArduinoParameterDto Parameter
		{
			get;
			set;
		}
		#endregion
	}
}
