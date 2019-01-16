document.write("<script language=javascript src='mui.min.js'></script>");
document.write("<script language=javascript src='jquery-1.7.2.min.js'></script>");
var scan = null;//扫描对象
		mui.plusReady(function () {
	          mui.init();
		  startRecognize();
	       });
			
		function startRecognize(){
		   try{
			  var filter;
			 //自定义的扫描控件样式
			 var styles = {frameColor: "#29E52C",scanbarColor: "#29E52C",background: ""}
			//扫描控件构造
			scan = new plus.barcode.Barcode('bcid',filter,styles);
			scan.onmarked = onmarked; 
			scan.onerror = onerror;
			scan.start();
			//打开关闭闪光灯处理
			var flag = false;
			document.getElementById("turnTheLight").addEventListener('tap',function(){
			   if(flag == false){
			      scan.setFlash(true);
			      flag = true;
			   }else{
			     scan.setFlash(false);
			     flag = false;
			   }
			});
		  }catch(e){
			alert("出现错误啦:\n"+e);
		     }
		  };
			function onerror(e){
					alert(e);
			};
			function onmarked( type, result ) {
					var text = '';
					switch(type){
						case plus.barcode.QR:
						text = 'QR: ';
						break;
						case plus.barcode.EAN13:
						text = 'EAN13: ';
						break;
						case plus.barcode.EAN8:
						text = 'EAN8: ';
						break;
					}
					alert( text + " : "+ result );
					
			};	
			    
		// 从相册中选择二维码图片 
// 		function scanPicture() {
// 		    plus.gallery.pick(function(path){
// 			    plus.barcode.scan(path,onmarked,function(error){
// 					plus.nativeUI.alert( "无法识别此图片" );
// 				});
// 		    },function(err){
// 		        plus.nativeUI.alert("Failed: "+err.message);
// 		    });
// 		}	    
		$("#scan").on('click',function(){
			console.log(11111111)
			plus.gallery.pick(function(path){
				plus.barcode.scan(path,onmarked,function(error){
					plus.nativeUI.alert( "无法识别此图片" );
				});
			},function(err){
				plus.nativeUI.alert("Failed: "+err.message);
			});
		})	    