angular.module('umbraco.resources')
	.factory('testResource', function ($http) {
	    return {
	        refresh: function () {
	            return $http.get('backoffice/User/Userapi/GetUserList');
	            //return $http.get('backoffice/apppoolrefresh/apppoolrefreshapi/refresh');
	        }
	    };
	});