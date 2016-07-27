angular.module('umbraco').controller('test.Controller',
	function ($scope, $route, $log, $timeout, testResource) {

	    $scope.refresh = function () {

	        //testResource.refresh().then(function (response) {


	        //    //$scope.isProcessing = true;
	        //    //testResource.refresh().then(function (response) {
	        //    //    $timeout(function () {
	        //    //        $scope.isProcessing = false;
	        //    //        //window.location.reload(true);
	        //    //    }, 1000);
	        //    //});
	        //});
	    };
	});
