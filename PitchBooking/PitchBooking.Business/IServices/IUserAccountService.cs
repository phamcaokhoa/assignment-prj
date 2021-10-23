﻿using PitchBooking.Business.Requests.UserAccountRequest;
using PitchBooking.Business.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PitchBooking.Business.IServices
{
    public interface IUserAccountService
    {
        public Task<bool> RegisterAccount(UserAccountRequest request);
        public Task<UserAccountModel> UpdateProfile(UserAccountRequest request);
    }
}
