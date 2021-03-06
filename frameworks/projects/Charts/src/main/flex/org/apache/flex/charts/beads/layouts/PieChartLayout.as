////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.charts.beads.layouts
{	
	import org.apache.flex.charts.core.IChartItemRenderer;
	import org.apache.flex.charts.core.IChartSeries;
	import org.apache.flex.charts.supportClasses.IWedgeItemRenderer;
	import org.apache.flex.charts.supportClasses.PieSeries;
	import org.apache.flex.core.IBeadLayout;
	import org.apache.flex.core.ISelectionModel;
	import org.apache.flex.core.ILayoutHost;
	import org.apache.flex.core.IParentIUIBase;
	import org.apache.flex.graphics.IFill;
	import org.apache.flex.graphics.SolidColor;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	
	/**
	 *  The PieChartLayout class calculates the size and position of all of the itemRenderers for
	 *  a PieChart. 
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class PieChartLayout extends ChartBaseLayout implements IBeadLayout
	{
		/**
		 *  constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function PieChartLayout()
		{
		}
		
		/**
		 * @private
		 */
		override protected function performLayout():void
		{
			var selectionModel:ISelectionModel = chart.getBeadByType(ISelectionModel) as ISelectionModel;
			var dp:Array = selectionModel.dataProvider as Array;
			if (!dp)
				return;
			
            var layoutParent:ILayoutHost = strand.getBeadByType(ILayoutHost) as ILayoutHost;
            var contentView:IParentIUIBase = layoutParent.contentView as IParentIUIBase;
			
			var n:int = dp.length;
			
			var xpos:Number = 0;
			var useWidth:Number = contentView.width;
			var useHeight:Number = contentView.height;
			
			var maxYValue:Number = 0;
			var seriesMaxes:Array = [];
			var colors:Array = [0xFF964D, 0x964DFF, 0xF80012, 0x96FF4D, 0x4D96FF, 0x8A8A01, 0x23009C, 0x4A4A4A, 0x23579D];
			
			for (var s:int = 0; s < chart.series.length; s++)
			{
				var pcs:PieSeries = chart.series[s] as PieSeries;
				
				for (var i:int = 0; i < n; i++)
				{
					var data:Object = dp[i];
					var field:String = pcs.dataField;
					
					var yValue:Number = Number(data[field]);
					maxYValue += yValue;
					
					seriesMaxes.push( {yValue:yValue, percent:0, arc:0} );
				}
				
				for (i=0; i < n; i++)
				{
					var obj:Object = seriesMaxes[i];
					obj.percent = obj.yValue / maxYValue;
					obj.arc = 360.0*obj.percent;					
				}
				
				var start:Number = 0;
				var end:Number = 0;
				var radius:Number = Math.min(useWidth,useHeight)/2;
				var centerX:Number = useWidth/2;
				var centerY:Number = useHeight/2;
								
				for (i=0; i < n; i++)
				{
					obj = seriesMaxes[i];
					data = dp[i];
					
					var fill:SolidColor = new SolidColor();
					fill.color = colors[i%colors.length];
					fill.alpha = 1.0;
					
					var child:IWedgeItemRenderer = chartDataGroup.getItemRendererForSeriesAtIndex(chart.series[s],i) as IWedgeItemRenderer;
					child.fill = fill;
					
					end = start + (360.0 * obj.percent);
					var arc:Number = 360.0 * obj.percent;
					
					child.x = 0;
					child.y = 0;
					child.width = useWidth;
					child.height = useHeight;
					child.centerX = centerX;
					child.centerY = centerY;
					child.startAngle = start*Math.PI/180;
					child.arc = arc*Math.PI/180;
					child.radius = radius;
					
					start += arc;
				}
			}
			
			IEventDispatcher(chart).dispatchEvent(new Event("layoutComplete"));
		}
	}
}
