/* 
 * PROJECT: FLARToolKit
 * --------------------------------------------------------------------------------
 * This work is based on the FLARToolKit developed by
 *   R.Iizuka (nyatla)
 * http://nyatla.jp/nyatoolkit/
 *
 * The FLARToolKit is ActionScript 3.0 version ARToolkit class library.
 * Copyright (C)2008 Saqoosha
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * For further information please contact.
 *	http://www.libspark.org/wiki/saqoosha/FLARToolKit
 *	<saq(at)saqoosha.net>
 * 
 */
package org.libspark.flartoolkit.core.types.matrix 
{
	import org.libspark.flartoolkit.core.types.*;
	public class FLARDoubleMatrix44 implements IFLARDoubleMatrix
	{
		public var m00:Number;
		public var m01:Number;
		public var m02:Number;
		public var m03:Number;
		public var m10:Number;
		public var m11:Number;
		public var m12:Number;
		public var m13:Number;
		public var m20:Number;
		public var m21:Number;
		public var m22:Number;
		public var m23:Number;
		public var m30:Number;
		public var m31:Number;
		public var m32:Number;
		public var m33:Number;
		public static function createArray(i_number:int):Vector.<FLARDoubleMatrix44>
		{
			var ret:Vector.<FLARDoubleMatrix44>=new Vector.<FLARDoubleMatrix44>(i_number);
			for(var i:int=0;i<i_number;i++)
			{
				ret[i]=new FLARDoubleMatrix44();
			}
			return ret;
		}
		/**
		 * 配列の内容をセットします。順番は、00,01,02,03,10...の順です。
		 */
		public function setValue(i_value:Vector.<Number>):void
		{
			this.m00=i_value[ 0];
			this.m01=i_value[ 1];
			this.m02=i_value[ 2];
			this.m03=i_value[ 3];
			this.m10=i_value[ 4];
			this.m11=i_value[ 5];
			this.m12=i_value[ 6];
			this.m13=i_value[ 7];
			this.m20=i_value[ 8];
			this.m21=i_value[ 9];
			this.m22=i_value[10];
			this.m23=i_value[11];
			this.m30=i_value[12];
			this.m31=i_value[13];
			this.m32=i_value[14];
			this.m33=i_value[15];
			return;
		}
		/**
		 * i_valueの内容を、このインスタンスにセットします。
		 * @param i_value
		 */
		public function setValue_2(i_value:FLARDoubleMatrix44):void
		{
			this.m00=i_value.m00;
			this.m01=i_value.m01;
			this.m02=i_value.m02;
			this.m03=i_value.m03;
			this.m10=i_value.m10;
			this.m11=i_value.m11;
			this.m12=i_value.m12;
			this.m13=i_value.m13;
			this.m20=i_value.m20;
			this.m21=i_value.m21;
			this.m22=i_value.m22;
			this.m23=i_value.m23;
			this.m30=i_value.m30;
			this.m31=i_value.m31;
			this.m32=i_value.m32;
			this.m33=i_value.m33;
			return;
		}
		/**
		 * 行列の内容を配列に出力します。順番は、00,01,02,03,10...の順です。
		 */
		public function getValue(o_value:Vector.<Number>):void
		{
			o_value[ 0]=this.m00;
			o_value[ 1]=this.m01;
			o_value[ 2]=this.m02;
			o_value[ 3]=this.m03;
			o_value[ 4]=this.m10;
			o_value[ 5]=this.m11;
			o_value[ 6]=this.m12;
			o_value[ 7]=this.m13;
			o_value[ 8]=this.m20;
			o_value[ 9]=this.m21;
			o_value[10]=this.m22;
			o_value[11]=this.m23;
			o_value[12]=this.m30;
			o_value[13]=this.m31;
			o_value[14]=this.m32;
			o_value[15]=this.m33;
			return;
		}
		/**
		 * 行列の内容を転置してから配列に出力します。
		 * 順番は、00,10,20,30,01...の順です。
		 */	
		public function getValueT(o_value:Vector.<Number>):void
		{
			o_value[ 0]=this.m00;
			o_value[ 1]=this.m10;
			o_value[ 2]=this.m20;
			o_value[ 3]=this.m30;
			o_value[ 4]=this.m01;
			o_value[ 5]=this.m11;
			o_value[ 6]=this.m21;
			o_value[ 7]=this.m31;
			o_value[ 8]=this.m02;
			o_value[ 9]=this.m12;
			o_value[10]=this.m22;
			o_value[11]=this.m32;
			o_value[12]=this.m03;
			o_value[13]=this.m13;
			o_value[14]=this.m23;
			o_value[15]=this.m33;
			return;
		}
		/**
		 * 逆行列を計算して、i_srcのthisへ格納します。i_srcにはthisも指定可能です。
		 * @param i_src
		 * @return
		 */
		public function inverse(i_src:FLARDoubleMatrix44):Boolean
		{
			var a11:Number,a12:Number,a13:Number,a14:Number,a21:Number,a22:Number,a23:Number,a24:Number,a31:Number,a32:Number,a33:Number,a34:Number,a41:Number,a42:Number,a43:Number,a44:Number;
			var b11:Number,b12:Number,b13:Number,b14:Number,b21:Number,b22:Number,b23:Number,b24:Number,b31:Number,b32:Number,b33:Number,b34:Number,b41:Number,b42:Number,b43:Number,b44:Number;	
			var t1:Number,t2:Number,t3:Number,t4:Number,t5:Number,t6:Number;
			a11=i_src.m00;a12=i_src.m01;a13=i_src.m02;a14=i_src.m03;
			a21=i_src.m10;a22=i_src.m11;a23=i_src.m12;a24=i_src.m13;
			a31=i_src.m20;a32=i_src.m21;a33=i_src.m22;a34=i_src.m23;
			a41=i_src.m30;a42=i_src.m31;a43=i_src.m32;a44=i_src.m33;
			
			t1=a33*a44-a34*a43;
			t2=a34*a42-a32*a44;
			t3=a32*a43-a33*a42;
			t4=a34*a41-a31*a44;
			t5=a31*a43-a33*a41;
			t6=a31*a42-a32*a41;
			
			b11=a22*t1+a23*t2+a24*t3;
			b21=-(a23*t4+a24*t5+a21*t1);
			b31=a24*t6-a21*t2+a22*t4;
			b41=-(a21*t3-a22*t5+a23*t6);
			
			t1=a43*a14-a44*a13;
			t2=a44*a12-a42*a14;
			t3=a42*a13-a43*a12;
			t4=a44*a11-a41*a14;
			t5=a41*a13-a43*a11;
			t6=a41*a12-a42*a11;

			b12=-(a32*t1+a33*t2+a34*t3);
			b22=a33*t4+a34*t5+a31*t1;
			b32=-(a34*t6-a31*t2+a32*t4);
			b42=a31*t3-a32*t5+a33*t6;
			
			t1=a13*a24-a14*a23;
			t2=a14*a22-a12*a24;
			t3=a12*a23-a13*a22;
			t4=a14*a21-a11*a24;
			t5=a11*a23-a13*a21;
			t6=a11*a22-a12*a21;

			b13=a42*t1+a43*t2+a44*t3;
			b23=-(a43*t4+a44*t5+a41*t1);
			b33=a44*t6-a41*t2+a42*t4;
			b43=-(a41*t3-a42*t5+a43*t6);

			t1=a23*a34-a24*a33;
			t2=a24*a32-a22*a34;
			t3=a22*a33-a23*a32;
			t4=a24*a31-a21*a34;		
			t5=a21*a33-a23*a31;
			t6=a21*a32-a22*a31;

			b14=-(a12*t1+a13*t2+a14*t3);
			b24=a13*t4+a14*t5+a11*t1;
			b34=-(a14*t6-a11*t2+a12*t4);
			b44=a11*t3-a12*t5+a13*t6;
			
			var det_1:Number=(a11*b11+a21*b12+a31*b13+a41*b14);
			if(det_1==0){
				return false;
			}
			det_1=1/det_1;

			this.m00=b11*det_1;
			this.m01=b12*det_1;
			this.m02=b13*det_1;
			this.m03=b14*det_1;
			
			this.m10=b21*det_1;
			this.m11=b22*det_1;
			this.m12=b23*det_1;
			this.m13=b24*det_1;
			
			this.m20=b31*det_1;
			this.m21=b32*det_1;
			this.m22=b33*det_1;
			this.m23=b34*det_1;
			
			this.m30=b41*det_1;
			this.m31=b42*det_1;
			this.m32=b43*det_1;
			this.m33=b44*det_1;
			
			return true;
		}	
		public function transform3d( i_x:Number , i_y:Number , i_z:Number , o_out:FLARDoublePoint3d ):void
		{ 
			o_out.x = this.m00 * i_x + this.m01 * i_y + this.m02 * i_z + this.m03 ;
			o_out.y = this.m10 * i_x + this.m11 * i_y + this.m12 * i_z + this.m13 ;
			o_out.z = this.m20 * i_x + this.m21 * i_y + this.m22 * i_z + this.m23 ;
			return  ;
		}
		
		public function transform3d_2( i_in:FLARDoublePoint3d , o_out:FLARDoublePoint3d ):void
		{ 
			transform3d(i_in.x , i_in.y , i_in.z , o_out) ;
		}
		
		public function getZXYAngle( o_out:FLARDoublePoint3d ):void
		{ 
			var sina:Number = this.m21 ;
			if( sina >= 1.0 ) {
				o_out.x = Math.PI / 2 ;
				o_out.y = 0 ;
				o_out.z = Math.atan2(-this.m10 , this.m00) ;
			}
			else if( sina <= -1.0 ) {
				o_out.x = -Math.PI / 2 ;
				o_out.y = 0 ;
				o_out.z = Math.atan2(-this.m10 , this.m00) ;
			}
			else {
				o_out.x = Math.asin(sina) ;
				o_out.z = Math.atan2(-this.m01 , this.m11) ;
				o_out.y = Math.atan2(-this.m20 , this.m22) ;
			}
		}
		
		public function mul( i_mat_l:FLARDoubleMatrix44 , i_mat_r:FLARDoubleMatrix44 ):void
		{ 
			//assert( ! (( this != i_mat_l ) ) );
			//assert( ! (( this != i_mat_r ) ) );
			this.m00 = i_mat_l.m00 * i_mat_r.m00 + i_mat_l.m01 * i_mat_r.m10 + i_mat_l.m02 * i_mat_r.m20 + i_mat_l.m03 * i_mat_r.m30 ;
			this.m01 = i_mat_l.m00 * i_mat_r.m01 + i_mat_l.m01 * i_mat_r.m11 + i_mat_l.m02 * i_mat_r.m21 + i_mat_l.m03 * i_mat_r.m31 ;
			this.m02 = i_mat_l.m00 * i_mat_r.m02 + i_mat_l.m01 * i_mat_r.m12 + i_mat_l.m02 * i_mat_r.m22 + i_mat_l.m03 * i_mat_r.m32 ;
			this.m03 = i_mat_l.m00 * i_mat_r.m03 + i_mat_l.m01 * i_mat_r.m13 + i_mat_l.m02 * i_mat_r.m23 + i_mat_l.m03 * i_mat_r.m33 ;
			this.m10 = i_mat_l.m10 * i_mat_r.m00 + i_mat_l.m11 * i_mat_r.m10 + i_mat_l.m12 * i_mat_r.m20 + i_mat_l.m13 * i_mat_r.m30 ;
			this.m11 = i_mat_l.m10 * i_mat_r.m01 + i_mat_l.m11 * i_mat_r.m11 + i_mat_l.m12 * i_mat_r.m21 + i_mat_l.m13 * i_mat_r.m31 ;
			this.m12 = i_mat_l.m10 * i_mat_r.m02 + i_mat_l.m11 * i_mat_r.m12 + i_mat_l.m12 * i_mat_r.m22 + i_mat_l.m13 * i_mat_r.m32 ;
			this.m13 = i_mat_l.m10 * i_mat_r.m03 + i_mat_l.m11 * i_mat_r.m13 + i_mat_l.m12 * i_mat_r.m23 + i_mat_l.m13 * i_mat_r.m33 ;
			this.m20 = i_mat_l.m20 * i_mat_r.m00 + i_mat_l.m21 * i_mat_r.m10 + i_mat_l.m22 * i_mat_r.m20 + i_mat_l.m23 * i_mat_r.m30 ;
			this.m21 = i_mat_l.m20 * i_mat_r.m01 + i_mat_l.m21 * i_mat_r.m11 + i_mat_l.m22 * i_mat_r.m21 + i_mat_l.m23 * i_mat_r.m31 ;
			this.m22 = i_mat_l.m20 * i_mat_r.m02 + i_mat_l.m21 * i_mat_r.m12 + i_mat_l.m22 * i_mat_r.m22 + i_mat_l.m23 * i_mat_r.m32 ;
			this.m23 = i_mat_l.m20 * i_mat_r.m03 + i_mat_l.m21 * i_mat_r.m13 + i_mat_l.m22 * i_mat_r.m23 + i_mat_l.m23 * i_mat_r.m33 ;
			this.m30 = i_mat_l.m30 * i_mat_r.m00 + i_mat_l.m31 * i_mat_r.m10 + i_mat_l.m32 * i_mat_r.m20 + i_mat_l.m33 * i_mat_r.m30 ;
			this.m31 = i_mat_l.m30 * i_mat_r.m01 + i_mat_l.m31 * i_mat_r.m11 + i_mat_l.m32 * i_mat_r.m21 + i_mat_l.m33 * i_mat_r.m31 ;
			this.m32 = i_mat_l.m30 * i_mat_r.m02 + i_mat_l.m31 * i_mat_r.m12 + i_mat_l.m32 * i_mat_r.m22 + i_mat_l.m33 * i_mat_r.m32 ;
			this.m33 = i_mat_l.m30 * i_mat_r.m03 + i_mat_l.m31 * i_mat_r.m13 + i_mat_l.m32 * i_mat_r.m23 + i_mat_l.m33 * i_mat_r.m33 ;
			return  ;
		}
		
		public function identity():void
		{ 
			this.m00 = this.m11 = this.m22 = this.m33 = 1 ;
			this.m01 = this.m02 = this.m03 = this.m10 = this.m12 = this.m13 = this.m20 = this.m21 = this.m23 = this.m30 = this.m31 = this.m32 = 0 ;
			return;
		}
		
		public function setRotateX( i_radian:Number ):void
		{ 
			var s:Number = Math.sin(i_radian) ;
			var c:Number = Math.cos(i_radian) ;
			this.identity() ;
			this.m11 = c ;
			this.m12 = -s ;
			this.m21 = s ;
			this.m22 = c ;
			return  ;
		}
		
		public function setRotateY( i_radian:Number ):void
		{ 
			var s:Number = Math.sin(i_radian) ;
			var c:Number = Math.cos(i_radian) ;
			this.identity() ;
			this.m00 = c ;
			this.m02 = s ;
			this.m20 = -s ;
			this.m22 = c ;
		}
		
		public function setRotateZ( i_radian:Number ):void
		{ 
			var s:Number = Math.sin(i_radian) ;
			var c:Number = Math.cos(i_radian) ;
			this.identity() ;
			this.m00 = c ;
			this.m01 = -s ;
			this.m10 = s ;
			this.m11 = c ;
		}
		
		public function setTranslate( i_x:Number , i_y:Number , i_z:Number ):void
		{ 
			this.identity() ;
			this.m03 = i_x ;
			this.m13 = i_y ;
			this.m23 = i_z ;
		}
		
		public function rotateX( i_radian:Number ):void
		{ 
			var s:Number = Math.sin(i_radian) ;
			var c:Number = Math.cos(i_radian) ;
			var t1:Number , t2:Number ;
			t1 = this.m01 ;
			t2 = this.m02 ;
			this.m01 = t1 * c + t2 * s ;
			this.m02 = t1 * ( -s ) + t2 * c ;
			t1 = this.m11 ;
			t2 = this.m12 ;
			this.m11 = t1 * c + t2 * s ;
			this.m12 = t1 * ( -s ) + t2 * c ;
			t1 = this.m21 ;
			t2 = this.m22 ;
			this.m21 = t1 * c + t2 * s ;
			this.m22 = t1 * ( -s ) + t2 * c ;
			t1 = this.m31 ;
			t2 = this.m32 ;
			this.m31 = t1 * c + t2 * s ;
			this.m32 = t1 * ( -s ) + t2 * c ;
		}
		
		public function rotateY( i_radian:Number ):void
		{ 
			var s:Number = Math.sin(i_radian) ;
			var c:Number = Math.cos(i_radian) ;
			var t1:Number , t2:Number ;
			t1 = this.m00 ;
			t2 = this.m02 ;
			this.m00 = t1 * c + t2 * ( -s ) ;
			this.m02 = t1 * s + t2 * c ;
			t1 = this.m10 ;
			t2 = this.m12 ;
			this.m10 = t1 * c + t2 * ( -s ) ;
			this.m12 = t1 * s + t2 * c ;
			t1 = this.m20 ;
			t2 = this.m22 ;
			this.m20 = t1 * c + t2 * ( -s ) ;
			this.m22 = t1 * s + t2 * c ;
			t1 = this.m30 ;
			t2 = this.m32 ;
			this.m30 = t1 * c + t2 * ( -s ) ;
			this.m32 = t1 * s + t2 * c ;
		}
		
		public function rotateZ( i_radian:Number ):void
		{ 
			var s:Number = Math.sin(i_radian) ;
			var c:Number = Math.cos(i_radian) ;
			var t1:Number , t2:Number ;
			t1 = this.m00 ;
			t2 = this.m01 ;
			this.m00 = t1 * c + t2 * s ;
			this.m01 = t1 * ( -s ) + t2 * c ;
			t1 = this.m10 ;
			t2 = this.m11 ;
			this.m10 = t1 * c + t2 * s ;
			this.m11 = t1 * ( -s ) + t2 * c ;
			t1 = this.m20 ;
			t2 = this.m21 ;
			this.m20 = t1 * c + t2 * s ;
			this.m21 = t1 * ( -s ) + t2 * c ;
			t1 = this.m30 ;
			t2 = this.m31 ;
			this.m30 = t1 * c + t2 * s ;
			this.m31 = t1 * ( -s ) + t2 * c ;
			return  ;
		}
		
		public function translate( i_x:Number , i_y:Number , i_z:Number ):void
		{ 
			this.m03 = this.m00 * i_x + this.m01 * i_y + this.m02 * i_z + this.m03 ;
			this.m13 = this.m10 * i_x + this.m11 * i_y + this.m12 * i_z + this.m13 ;
			this.m23 = this.m20 * i_x + this.m21 * i_y + this.m22 * i_z + this.m23 ;
			this.m33 = this.m30 * i_x + this.m31 * i_y + this.m32 * i_z + this.m33 ;
			return  ;
		}
	
		/**
		 * この関数は、インスタンスに単位行列をロードします。
		 */
		public function loadIdentity():void
		{
			this.m00=this.m11=this.m22=this.m33=1;
			this.m01=this.m02=this.m03=
			this.m10=this.m12=this.m13=
			this.m20=this.m21=this.m23=
			this.m30=this.m31=this.m32=0;
		}

	}
}