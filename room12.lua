--красное море
-- Доступное пространство имён для объектов - все имена объектов должны начинаться с "room12_" или "gostinnaya_" 
-- Все описания можно менять
-- Задача: Игрок должен найти в локации кодовое слово или набор цифр. Кодовое слово придумываете вы, желательно указать его в комментариях в первой строке файла, чтобы я потом заменил его в файле другого автора
-- Крайне желательно чтобы игроку было более или менее явно понятно, что это кодовое слово, которое может пригодится дальше в процессе игры
-- Также - выход на север изначально закрыт, и открывается из этой комнаты, способ открыть дверь остаётся на усмотрение автора
-- Также - кабинет на востоке изначально закрыт, и открывается с помощью предмета squarekey, игрок может зайти в локацию как с этим предметом, так и без него

obj {
	-"квадратный ключ,ключ";
	nam = "squarekey";
	description = "Квадратный ключ.";
        score=false;
        after_Take = function(s)
          if not s.score then
            mp.score=mp.score+1;
          end;
          _'squarekey'.score=true;
          return false;
        end;
}

room {
	nam = "room12_gostinnaya";
	title = "Гостиная";
	dsc = function()
		p "В гостиной тихо и спокойно. Пылинки пляшут в потоке света из-под огромного абажура в центре потолка. Углы комнаты тонут в темноте.";
		if _'room12_портал':has'on' then
			p 'Ну не считая конечно того, что в дверных проёмах ведущих на север и запад видна картинка явно не соответствующая соседним комнатам.';
		end;
	end;
	n_to = 'room2_on_terrasa'; --терасса
	e_to = 'room13_library'; --библиотека
	s_to = 'room10_zal'; --зал
	w_to = 'room11_kabinet'; --кабинет
	before_Listen = "Не считая шумов свойственных старому дому, ничего не слышно.";
	before_Smell = "Пахнет пылью и почему-то озоном.";
	before_Think = "Всё страньше и страньше! Всё чудесатее и чудесатее! Всё любопытственнее и любопытственнее! Всё страннее и страннее! Всё чудесится и чудесится!";
	before_Wait = "Я немного подождала. Внезапно из шкафа послышался какой-то неясный звук. Мыши наверное.";
	before_Taste = 'Как-то в детстве я лизнула железные качели в декабре. С тех пор стараюсь явно несъедобные объекты не лизать.';
	obj = {'room12_шкаф', 'room12_стол', 'room12_кресло', 'room12_лампа', 'room12_фото', 'room12_пол', 'room12_потолок', 'room12_стены'};
	compass_look = function(s,dir)
		if _'room12_портал':has'on' then
			if dir == 'n_to' then
				p 'В двери ведущей на север видны бесконечные морские просторы без каких-либо признаков жизни. Конечно проверять голограмма ли это или правда, а если даже и второе, то есть ли вход с той стороны, я не буду. Тем более плаваю я посредственно.';
			elseif dir == 'w_to' then
				p 'В двери ведущей на запад видна какая-то пустыня, только какая-то серая и со странным резким освещением. Я провела взглядом по странно близкому горизонту и зависла над невозможной картиной. Из-за горизонта неспешно выкатывался сине-зеленый шар планеты с очень узнаваемыми очертаниями материков. Я в испуге отшатнулась.';
			else
				p 'С этой стороны находится обычная дверь, ведущая очевидно в соседнее помещение.';
			end;
		else
			p 'С этой стороны находится обычная дверь, ведущая очевидно в соседнее помещение.';
		end;
	end;
	['before_Walk,Enter'] = function(s,w)
		if mp:compass_dir(w) == 'n_to' or mp:compass_dir(w) == 'w_to' then
			if _'room12_портал':has'on' then
				p 'Шагать в неизвестность как минимум неразумно. Стоит сначала осмотреться.';
			else
				return false;
			end;
		else
			return false;
		end;
	end;
}

obj {
	-"фотография|портрет|диск";
	nam = 'room12_фото';
	description = 'На стене висит фотография улыбающегося молодого мужчины, замотанного в бурнус (или как там эта арабская одежда называется?), на фоне морского берега. В руках он держит красный керамический диск покрытый резьбой в виде круговых орнаментов и неизвестных символов.';
	before_Take = 'Портрет как-то намертво приделан к стене. Приклеен что-ли?';
}:attr 'static';

obj {
	-"бордовая лампа, лампа|абажур";
	nam = 'room12_лампа';
	description = 'Огромный бордовый абажур с оборками. Выглядит очень пыльным.';
	before_SwitchOff = 'Выключателя что-то не видно.';
	before_Take = 'Я не дотягиваюсь. Слишком высоко.';
}:attr 'scenery';

obj {
	-"пол|паркет";
	nam = 'room12_пол';
	description = 'Пол покрыт старым потёртым паркетом.';
}:attr 'scenery';

obj {
	-"потолок";
	nam = 'room12_потолок';
	description = 'Потолок покрашен белой краской, пожелтевшей от времени. Посередине находится огромный абажур с лампой.';
}:attr 'scenery';

obj {
	-"стены|стена";
	nam = 'room12_стены';
	description = 'Стены оббиты тканью с выгоревшим цветочным рисунком, как это было модно в начале прошлого века. Во всех четырех направлениях есть выходы в соседние комнаты.';
}:attr 'scenery';

obj {
	-"шкаф|резьба|дверцы|символы|буквы";
	nam = 'room12_шкаф';
	description = 'Винтажного вида платяной шкаф с украшенными затейливой резьбой дверцами. В резьбе местами угадываются какие-то буквы и символы.';
	obj = {};
	['before_Walk,Enter,Open'] = function(s)
		if s:once() then
			p 'Открыв шкаф я увидела вовсе не пустые вешалки как ожидалось. Вместо задней стенки я обнаружила ночь, заметенную снегом поляну и чугунный фонарь. Внезапно в темноте за кругом света от фонаря мне почудилось какое-то движение, из темноты выступили очертания чего-то. Неестественные и отвратительные. Первобытный ужас охватил меня, холод прокатился по позвоночнику и я поспешно захлопнула дверцу шкафа.';
		elseif _'room12_портал':has'on' then
			p 'Нет уж. Там страшно.';
		else
			p 'Шкаф совершенно пуст. Я прикрыла дверцы обратно.';
		end;
	end;
	before_Take = 'Я не думаю, что смогу даже на миллиметр подвинуть этот шкаф.';
}:attr 'static';

obj {
	-"стол";
	nam = 'room12_стол';
	description = 'Круглый обеденный стол. Весьма старый судя по потертому лаку на столешнице.';
	obj = {'room12_ноутбук'};
	before_Take = 'Слишком большой, чтобы я могла справиться с ним.';
	before_LookUnder = 'Кроме следов мышей в пыли тут ничего нет.';
}:attr 'static, supporter, enterable';

obj {
	-"кресло";
	nam = 'room12_кресло';
	description = 'Массивное винтажное кресло с резной спинкой. Оббито полосатой тканью.';
	before_Take = 'Это кресло слишком тяжёлое.';
}:attr 'static, supporter, enterable';

obj {
	-"стальной кейс,кейс,стальной чемодан,чемодан,ноутбук,компьютер,экран";
	nam = "room12_ноутбук";
	description = function(s)
		if s:has'open' then
			p "На экране светится что-то типа нортон-коммандера. Но почти все директории оказались заблокированы. В документах я нашла единственный файл подписанный 'код'. И ещё загадочное приложение 'портал'.";
		else
			p "Массивный стальной кейс с закруглёнными уголками. На замке кейса есть квадратное отверстие под ключ.";
		end
	end;
	obj = {'room12_файл', 'room12_портал'};
	with_key = 'squarekey';
	before_Take = 'Я попыталась снять кейс со стола, но внутри что-то очень тяжёлое. Даже тяжелее той сумки, что я собрала в тот раз в отпуск.';
	before_LetIn = 'Положить ключ в кейс и захлопнуть его. Прекрасная идея. Я как-то с машиной это проделала, пришлось специального слесаря вызывать. Так что как-нибудь потом.';
	before_SwitchOff = 'Каких-то специальных кнопок для выключения ноутбука я не нашла. Может быть достаточно закрыть его?';
	after_Open = function()
		p 'Кейс оказался каким-то древним ноутбуком. С выпуклым экраном и непривычной раскладкой клавиатуры. На экране замигали надписи и загрузилась незнакомая операционная система.';
--		place('squarekey','room12_стол');
                remove('squarekey')
	end;
}:attr 'static, openable, lockable, locked, container';

obj {
	-"файл,код";
	nam = 'room12_файл';
	description = "Файл называется code.txt. В файле единственная строчка 'красное море'.";
	before_Open = "В файле единственная строчка 'красное море'.";
	before_Take = 'В ноутбуке есть какие-то разъёмы сбоку, но это явно не USB. Да и флешки у меня нет с собой.';
}:attr 'scenery';

obj {
	-"программа|портал";
	nam = 'room12_портал';
	description = "Этот файл называется portal.bin.";
	['before_Open,SwitchOff,SwitchOn'] = function(s)
		p "Поверх вылезло окошко терминала, быстро мигнуло несколько строк и окошко закрылось.";
		if s:has'on' then
			p "Это так и должно быть? Порталы же зашипели и погасли, открыв за собой проёмы дверей в соседние комнаты.";
			s:attr'~on'
			_'room2_door':attr'~locked'
			_'room2_door':attr'open'
			mp.score=mp.score+1
		else
			p "И больше ничего не произошло.";
		end;		
	end;
	before_Take = 'В ноутбуке есть какие-то разъёмы сбоку, но это явно не USB. Да и флешки у меня нет с собой.';
}:attr 'scenery, switchable, on';
