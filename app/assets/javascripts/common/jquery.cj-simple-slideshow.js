/*globals clearTimeout,jQuery,setTimeout */
/* ***********************************************************************************

	CJ Simple Slideshow JavaScript framework

	Copyright (c) 2008, Doug Jones. All rights reserved.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions
	are met:
	
	a) Redistributions of source code must retain the above copyright
	   notice, this list of conditions and the following disclaimer.
	  
	b) Redistributions in binary form must reproduce the above copyright
	   notice, this list of conditions and the following disclaimer in the
	   documentation and/or other materials provided with the distribution. 
	  
	c) Neither the name of the Creative Juices, Bo. Co. nor the names of its
	   contributors may be used to endorse or promote products derived from
	   this software without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
	A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
	OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
	LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
	THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

	For further information, visit the Creative Juices website: www.cjboco.com.
	
	Version History
	
	2.1.1 (06-27-2009) - Fixed the IE bugs.
	2.1 (06-24-2009) - Stripped out a lot of the style features.
			It really didn't make sense to do it here, since it
			could be done easily with CSS. Plus is was causing
			issues with IE.
	2.0 (06-14-2009) - Converted it to a JQuery plug-in.
	1.0 (10-02-2006) - Initial release.

*********************************************************************************** */
(function($) {
	$.fn.cjSimpleSlideShow = function(options) {

		var settings = {
			// user editable settings
			autoRun: true,
			delay: 3000,
			dissolve: 70,
			showCaptions: false,
			centerImage: false
		};

		var sys = {
			// function parameters
			version: '2.1.1',
			elem: null,
			slides: [],
			captions: [],
			current: 0,
			timer: null,
			pause: false
		};

		/* 
			sets a slides opacity
		***************************************/
		function setOpacity(o) {
			if (parseFloat(o.t) > 1) {
				o.t = 1.0;
				return;
			}
			$(o).css({
				"opacity": parseFloat(o.t),
				"MozOpacity": parseFloat(o.t),
				"filter": "alpha(opacity=" + (parseFloat(o.t) * 100) + ")"
			});
		}

		/* 
			sets the slide and handles dissolves
		***************************************/
		function setSlide() {
			var o = parseFloat(sys.slides[sys.current].t);
			var x = sys.slides[sys.current + 1] ? sys.current + 1 : 0;
			var no = parseFloat(sys.slides[x].t);
			o -= 0.05;
			no += 0.05;
			$(sys.slides[x]).css({
				"display": "block"
			});
			sys.slides[sys.current].t = parseFloat(o);
			sys.slides[x].t = parseFloat(no);
			setOpacity(sys.slides[sys.current]);
			setOpacity(sys.slides[x]);
			if (sys.captions[sys.current] && sys.captions[x]) {
				$(sys.captions[x]).css({
					"display": "block"
				});
				sys.captions[sys.current].t = parseFloat(o);
				sys.captions[x].t = parseFloat(no);
				setOpacity(sys.captions[sys.current]);
				setOpacity(sys.captions[x]);
			}
			if (o <= 0) {
				$(sys.slides[sys.current]).css({
					"display": "none"
				});
				if (sys.captions[x]) {
					$(sys.captions[x]).css({
						"display": "block"
					});
					$(sys.captions[sys.current]).css({
						"display": "none"
					});
				}
				sys.current = x;
				if (!sys.pause) {
					sys.timer = setTimeout(setSlide, settings.delay);
				}
			} else {
				if (!sys.pause) {
					sys.timer = setTimeout(setSlide, settings.dissolve);
				}
			}
		}

		/* 
			pauses the slideshow
		***************************************/
		function pause() {
			sys.pause = true;
			if (sys.timer) {
				clearTimeout(sys.timer);
				sys.timer = null;
			}
			$(sys.elem).find("div.cj_slideshow_pause_wrapper").fadeIn("fast");
		}

		/* 
			resumes the slideshow
		***************************************/
		function resume() {
			sys.pause = false;
			$(sys.elem).find("div.cj_slideshow_pause_wrapper").fadeOut("fast");
			sys.timer = setTimeout(setSlide, 0);
		}

		/* 
			initialize the slideshow & slides
		***************************************/
		function init() {

			// need to make sure the positioning is set for the main container.
			// it needs to be set to anything other than STATIC
			if ($(sys.elem).css("position") === "" || $(sys.elem).css("position") === "static") {
				$(sys.elem).css("position", "relative");
			}

			// create our main slideshow wrapper
			var i, wrapper = $("<div>").css({
				"display": "block",
				"width": "0px",
				"height": "0px",
				"position": "absolute",
				"overflow": "hidden",
				"cursor": "pointer"
			}).addClass("cj_slideshow_wrapper"),
			pauseBlock = $("<div>").css({
				"display": "none",
				"position": "absolute",
				"z-index": "10"
			}).html("Paused").addClass("cj_slideshow_pause_wrapper");

			// loop through the images and initialize some settings
			$(sys.elem).find("img").each(function() {
				sys.slides.push($(this).get(0));
			}).css({
				"position": "absolute",
				"top": "0px",
				"left": "0px"
			}).wrapAll($(wrapper));
			$(sys.elem).find("div.cj_slideshow_wrapper").append(pauseBlock).bind("mouseenter", function() {
				pause();
			}).bind("mouseleave", function() {
				resume();
			});
			$(sys.elem).find("br").css({
				"display": "none"
			});

			$(sys.elem).css({
				"display": "block"
			});

			// center the image? we need the images to have the display set to none in order to start the transitions
			// but in order to get the width and height in Internet Explorer, they need to be visible... (or display=block)
			$(sys.elem).find("img").each(function() {
				var i = this;
				if (settings.centerImage) {
					$(i).css({
						"display": "none",
						"top": settings.centerImage ? parseInt(($(sys.elem).height() - $(i).attr("height")) / 2, 10) + "px": "0px",
						"left": settings.centerImage ? parseInt(($(sys.elem).width() - $(i).attr("width")) / 2, 10) + "px": "0px"
					});
				} else {
					$(i).css({
						"display": "none"
					});
				}
			});

			// captions?
			for (i = 0; i < sys.slides.length; i++) {
				sys.slides[i].t = 0.0;
				if (settings.showCaptions) {
					if ($(sys.slides[i]).attr("alt") !== "") {
						var cap = $("<span>").css({
							"position": "absolute",
							"display": "none",
							"width": "100%",
							"height": "auto"
						}).addClass("cj_slideshow_caption_wrapper").html($(sys.slides[i]).attr("alt"));
						$(sys.slides[i]).after(cap);
						sys.captions.push($(sys.slides[i]).next("span"));
						sys.captions[i].t = 0.0;
					} else {
						sys.captions.push(null);
						sys.captions[i].t = 0.0;
					}
				}
			}

			// make the first slide and/or caption visisable
			if (sys.slides.length > 0) {
				$(sys.slides[0]).css({
					"display": "block"
				});
				sys.slides[0].t = 1.0;
				if (sys.captions[0]) {
					$(sys.captions[0]).css({
						"display": "block"
					});
					sys.captions[0].t = 1.0;
				}
				// show our main elem, if it was hidden
				$(sys.elem).find(".cj_slideshow_wrapper").css({
					"width": $(sys.elem).width(),
					"height": $(sys.elem).height()
				});
			}

		}

		function start() {
			sys.timer = setTimeout(setSlide, settings.delay);
		}

		/* 
			set up any user passed variables
		***************************************/
		if (options) {
			$.extend(settings, options);
		}

		/* 
			begin
		***************************************/
		return this.each(function() {
			sys.elem = this;
			init();
			if (settings.autoRun) {
				start();
			}
		});

	};
})(jQuery);