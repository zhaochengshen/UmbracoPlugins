using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace AppPoolRestart.Plugin.Models
{
    public class User
    {

        /// <summary>
        /// auto_increment
        /// </summary>		
        /// 
        [ScaffoldColumn(false)]
        private int _id;
        public int id
        {
            get { return _id; }
            set { _id = value; }
        }
        /// <summary>
        /// userDisabled
        /// </summary>		
        private int _userdisabled;
        public int userDisabled
        {
            get { return _userdisabled; }
            set { _userdisabled = value; }
        }
        /// <summary>
        /// userNoConsole
        /// </summary>		
        private int _usernoconsole;
        public int userNoConsole
        {
            get { return _usernoconsole; }
            set { _usernoconsole = value; }
        }
        /// <summary>
        /// userType
        /// </summary>		
        private int _usertype;
        public int userType
        {
            get { return _usertype; }
            set { _usertype = value; }
        }
        /// <summary>
        /// startStructureID
        /// </summary>		
        private int _startstructureid;
        public int startStructureID
        {
            get { return _startstructureid; }
            set { _startstructureid = value; }
        }
        /// <summary>
        /// startMediaID
        /// </summary>		
        private int _startmediaid;
        public int startMediaID
        {
            get { return _startmediaid; }
            set { _startmediaid = value; }
        }
        /// <summary>
        /// userName
        /// </summary>		
        private string _username;
        public string userName
        {
            get { return _username; }
            set { _username = value; }
        }
        /// <summary>
        /// userLogin
        /// </summary>		
        private string _userlogin;
        public string userLogin
        {
            get { return _userlogin; }
            set { _userlogin = value; }
        }
        /// <summary>
        /// userPassword 
        /// </summary>		 

        [ScaffoldColumn(false)]
        private string _userpassword;

        public string userPassword
        {
            get { return _userpassword; }
            set { _userpassword = value; }
        }
        /// <summary>
        /// userEmail
        /// </summary>		
        private string _useremail;
        public string userEmail
        {
            get { return _useremail; }
            set { _useremail = value; }
        }
        /// <summary>
        /// userLanguage
        /// </summary>		
        private string _userlanguage;
        public string userLanguage
        {
            get { return _userlanguage; }
            set { _userlanguage = value; }
        }
        /// <summary>
        /// securityStampToken
        /// </summary>		
        private string _securitystamptoken;
        public string securityStampToken
        {
            get { return _securitystamptoken; }
            set { _securitystamptoken = value; }
        }
        /// <summary>
        /// failedLoginAttempts
        /// </summary>		
        private int _failedloginattempts;
        public int failedLoginAttempts
        {
            get { return _failedloginattempts; }
            set { _failedloginattempts = value; }
        }
        /// <summary>
        /// lastLockoutDate
        /// </summary>		
        private DateTime? _lastlockoutdate;
        public DateTime? lastLockoutDate
        {
            get { return _lastlockoutdate; }
            set { _lastlockoutdate = value; }
        }
        /// <summary>
        /// lastPasswordChangeDate
        /// </summary>		
        private DateTime? _lastpasswordchangedate;
        public DateTime? lastPasswordChangeDate
        {
            get { return _lastpasswordchangedate; }
            set { _lastpasswordchangedate = value; }
        }
        /// <summary>
        /// lastLoginDate
        /// </summary>		
        private DateTime? _lastlogindate;
        public DateTime? lastLoginDate
        {
            get { return _lastlogindate; }
            set { _lastlogindate = value; }
        }
    }
}