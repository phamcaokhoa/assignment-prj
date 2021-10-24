﻿using AutoMapper;
using PitchBooking.Business.Enum;
using PitchBooking.Business.ViewModel;
using PitchBooking.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PitchBooking.Business.AutoMapper
{
    public class BookingMapper : Profile
    {
        public BookingMapper()
        {
            CreateMap<Booking, BookingModel>()
                .ForMember(d => d.SubPitchName, s => s.MapFrom(s => s.SubPitch.Name))
                .ForMember(d => d.PitchName, s => s.MapFrom(s => s.SubPitch.Pitch.Name))
                .ForMember(d => d.Status, s => s.MapFrom(s => ConvertStatus(s.Status)));
        }

        private static BookingStatus ConvertStatus(int? status)
        {
            if (status == 2) return BookingStatus.Paid;
            else if (status == 1) return BookingStatus.Booked;
            else return BookingStatus.Cancel;
        }
    }
}
