using System;

namespace Iot.Events
{
	/// <summary>
	/// Представляет базовое события от Arduino.
	/// </summary>
	/// <seealso cref="Iot.Events.IEvent" />
	[Serializable]
	public abstract  class EventBase : IEvent
	{
		/// <summary>
		/// Возвращает the event identifier.
		/// </summary>
		/// <value>
		/// The event identifier.
		/// </value>
		public Guid EventId
		{
			get;
		} = Guid.NewGuid();

		/// <summary>
		/// Возвращает the event date time.
		/// </summary>
		/// <value>
		/// The event date time.
		/// </value>
		public DateTime EventDateTime
		{
			get;
		} = DateTime.Now;	 

	}
}