(function()
{
	// Время появления/исчезания
	var adboxShowTime = 300;
	// Прозрачность фона в итоге
	var adboxBackgroundFinalOpacity = 0.8;

	// асинхронная загрузка, вставлять на страницу, адрес скрипта пишется в s.src
	/*<script type="text/javascript">
		(function(d, w)
		{
			var n=d.getElementsByTagName('script')[0],
			s=d.createElement('script'),
			f=function () { n.parentNode.insertBefore(s, n); };
			s.src='http://www.wallpapers.ru/plugins/js.php?url='+window.location.href;
			s.type='text/javascript';
			s.async=true;
			if (w.opera=='[object Opera]') d.addEventListener('DOMContentLoaded', f);
			else f();
		})(document, window);
	</script>*/

	// определение 6, 7 и 8 осла
	if (!window._ua)
	{
		var adbboxUa = navigator.userAgent.toLowerCase();
		var adboxMsie6 = (/msie 6/i.test(adbboxUa) && !/opera/i.test(adbboxUa));
		var adboxMsie7 = (/msie 7/i.test(adbboxUa) && !/opera/i.test(adbboxUa));
		var adboxMsie8 = adboxMsie8 = (/msie 8/i.test(adbboxUa) && !/opera/i.test(adbboxUa));;
	}
	else var adboxMsie8 = (/msie 8/i.test(window._ua) && !/opera/i.test(window._ua));

	// расчёт коэффициентов для функций
	var adboxBackgroundParam = adboxBackgroundFinalOpacity/(adboxShowTime/50);
	var adboxPopupParam = 1/(adboxShowTime/50);

	// функция появления
	function adboxShow()
	{
		var adboxBackgroundOpacity = Number(adboxBackground.style.opacity) + adboxBackgroundParam;
		adboxBackground.style.opacity = adboxBackgroundOpacity;
		adboxBackground.style.filter='alpha(opacity='+adboxBackgroundOpacity*100+')';

		var adboxPopupOpacity = Number(adboxPopup.style.opacity) + adboxPopupParam;
		adboxPopup.style.opacity = adboxPopupOpacity;
		adboxPopup.style.filter='alpha(opacity='+adboxPopupOpacity*100+')';

		if (adboxPopupOpacity<1) window.setTimeout(function(){adboxShow()}, 50);
		else
		{
			adboxBackground.style.opacity = adboxBackgroundFinalOpacity;
			adboxBackground.style.filter='alpha(opacity='+adboxBackgroundFinalOpacity*100+')';
			adboxPopup.style.opacity = 1;
			adboxPopup.style.filter='';
			if (adboxMsie6 || adboxMsie7 || adboxMsie8) adboxImg.style.display = 'block';
			adboxImg.onclick = adboxClose;
			adboxBackground.onclick = adboxClose;
			var expires = new Date(); // получаем текущую дату
			expires.setTime(expires.getTime() + 86400000);
			//adboxSetCookie('adboxKey', true, expires);
		}
	}

	// функция исчезания
	function adboxClose()
	{
		if (adboxMsie6 || adboxMsie7 || adboxMsie8) adboxImg.style.display = 'none';

		var adboxPopupOpacity = Number(adboxPopup.style.opacity) - adboxPopupParam;
		if (adboxPopupOpacity<0) adboxPopupOpacity = 0;
		adboxPopup.style.opacity = adboxPopupOpacity;
		adboxPopup.style.filter='alpha(opacity='+adboxPopupOpacity*100+')';

		var adboxBackgroundOpacity = Number(adboxBackground.style.opacity) - adboxBackgroundParam;
		if (adboxBackgroundOpacity<0) adboxBackgroundOpacity = 0;
		adboxBackground.style.opacity = adboxBackgroundOpacity;
		adboxBackground.style.filter='alpha(opacity='+adboxBackgroundOpacity*100+')';

		// 0.001 вместо 0 потому что у гугл хрома переполнение
		if (adboxPopupOpacity>0.001) window.setTimeout(function(){adboxClose()}, 50);
		else
		{
			adboxBackground.parentNode.removeChild(adboxBackground);
			adboxPopup.parentNode.removeChild(adboxPopup);
		}
	}

	// функции куки
	function adboxSetCookie(name, value, expires)
	{
		if (!expires) expires = new Date();
		document.cookie = name + '=' + escape(value) + '; expires=' + expires.toGMTString() +  '; path=/';
	}

	function adboxGetCookie(name)
	{
		var cookie_name = name + '=';
		var cookie_length = document.cookie.length;
		var cookie_begin = 0;
		while (cookie_begin < cookie_length)
		{
			value_begin = cookie_begin + cookie_name.length;
			if (document.cookie.substring(cookie_begin, value_begin) == cookie_name)
			{
				var value_end = document.cookie.indexOf (';', value_begin);
				if (value_end == -1) value_end = cookie_length;
				return unescape(document.cookie.substring(value_begin, value_end));
			}
			cookie_begin = document.cookie.indexOf(' ', cookie_begin) + 1;
			if (cookie_begin == 0) break;
		}
		return null;
	}

	// получаем куки
	var adboxKey=adboxGetCookie('adboxKey');

	// если такой куки нет
	if (adboxKey==null || !adboxKey)
	{
		// получаем контент
		var adboxContent = '<div style="font: 20px Arial, sans-serif; text-align: center;"><a href="http://www.anapatur79.ru/" target="_blank" style="color: #00F;"><img src="http://www.anapamix.ru/1.jpg" width="200" height="133"><img src="http://www.anapamix.ru/2.jpg" width="200" height="133"><img src="http://www.anapamix.ru/3.jpg" width="200" height="133"><div style="padding-top: 5px;">Размещение в 3-х этажном коттедже Анапы без посредников</div></a></div>';

		// если есть, что показать
		if (adboxContent)
		{
			// создание элемента фона
			var adboxBackground = document.createElement('div');
			adboxBackground.style.padding = 0;
			adboxBackground.style.margin = 0;
			if (adboxMsie6)
			{
				adboxBackground.style.width = document.documentElement.clientWidth+'px';
				adboxBackground.style.height = document.body.offsetHeight+'px';
			}
			else
			{
				adboxBackground.style.width = '100%';
				adboxBackground.style.height = '100%';
			}
			adboxBackground.style.background = '#000000';
			adboxBackground.style.left = '0';
			adboxBackground.style.top = '0';
			adboxBackground.style.display = 'none';
			if (adboxMsie6) adboxBackground.style.position = 'absolute';
			else adboxBackground.style.position = 'fixed';
			adboxBackground.style.zIndex = '99997';
			document.getElementsByTagName('body')[0].appendChild(adboxBackground);
			adboxBackground.style.display = 'block';
			adboxBackground.style.opacity = 0;
			adboxBackground.style.filter='alpha(opacity=0)';

			// создание элемента бокса
			var adboxPopup = document.createElement('div');
			adboxPopup.style.padding = '10px';
			adboxPopup.style.margin = 0;
			adboxPopup.style.maxWidth = Math.round(document.compatMode=='CSS1Compat' && !window.opera?document.documentElement.clientWidth:document.body.clientWidth*0.8)+'px';
			adboxPopup.style.minWidth = '100px';
			adboxPopup.style.minHeight = '100px';
			adboxPopup.style.background = '#ffffff';
			adboxPopup.style.border = '10px solid #dddddd';
			adboxPopup.style.borderRadius = '10px';
			adboxPopup.style.boxShadow = '0px 0px 20px #000000';
			adboxPopup.style.display = 'none';
			adboxPopup.style.overflow='visible';
			if (adboxMsie6) adboxPopup.style.position = 'absolute';
			else adboxPopup.style.position = 'fixed'
			adboxPopup.style.left = '50%';
			adboxPopup.style.top = '50%';
			adboxPopup.style.zIndex = '99998';
			document.getElementsByTagName('body')[0].appendChild(adboxPopup);
			adboxPopup.style.display = 'block';
			adboxPopup.style.opacity = 0;
			adboxPopup.style.filter='alpha(opacity=0)';

			// создание элемента крестика
			var adboxImg = document.createElement('div');
			var adboxImg = document.createElement('img');
			adboxImg.style.padding = 0;
			adboxImg.width = 44;
			adboxImg.height = 44;
			adboxImg.alt = 'Закрыть';
			adboxImg.style.marginTop = '-30px';
			adboxImg.style.marginRight = '-30px';
			adboxImg.style.position = 'absolute';
			adboxImg.style.top = '0';
			adboxImg.style.right = '0';
			adboxImg.style.zIndex = '99999';
			adboxImg.src = 'http://www.wallpapers.ru/close_pop.png';
			adboxImg.style.cursor = 'pointer';
			if (adboxMsie6 || adboxMsie7 || adboxMsie8) adboxImg.style.display = 'none';
			adboxImg = adboxPopup.appendChild(adboxImg);

			// функция обработки нажатия на баннер
			var adboxContainer = document.createElement('div');
			adboxContainer.onclick = function()
			{
				var img = new Image();
				img.src = 'http://www.wallpapers.ru/plugins/js.php';
				adboxClose()
			};

			// заполнение контентом и центрирование
			adboxContainer.innerHTML = adboxContent;
			adboxPopup.appendChild(adboxContainer);
			adboxPopup.style.marginLeft = -Math.round(adboxPopup.offsetWidth/2)+'px';
			adboxPopup.style.marginTop = -Math.round(adboxPopup.offsetHeight/2)+'px';

			// ну, с бохом
			window.setTimeout(function(){adboxShow()}, 1000);
		}
	}
})();