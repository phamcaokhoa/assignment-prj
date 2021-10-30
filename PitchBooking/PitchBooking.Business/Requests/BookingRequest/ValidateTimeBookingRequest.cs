﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PitchBooking.Business.Requests.BookingRequest
{
    public class ValidateTimeBookingRequest
    {
        public int SubPitchId { get; set; }
        public DateTime DateBooing { get; set; }
        public TimeSpan TimeStart { get; set; }
        public TimeSpan TimeEnd { get; set; }
    }
}
