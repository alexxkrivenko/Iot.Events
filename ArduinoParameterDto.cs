using System;

namespace Iot.Events
{
	[Serializable]
	public class ArduinoParameterDto
	{
		#region Properties
		public Guid ParameterId
		{
			get;
			set;
		}

		public object Value
		{
			get;
			set;
		}
		#endregion
	}
}
