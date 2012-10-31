package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.WireframeCube;
	import cepa.utils.Cronometer;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class CamadaEletrons extends ObjectContainer3D
	{
		private var larguraAltura:Number;
		private var comprimento:Number;
		private var velMin:Number;
		private var velMax:Number;
		private var desvioVel:Number;
		private var nParticulas:Number;
		private var nParticulasFrame:Number = 10;
		private var vetorDeslocamento:Vector3D;
		public var velMult:Number = 1;
		public var cubo:WireframeCube;
		
		//private var cores:Array = [0x006600, 0x00D700];
		private var cores:Array = [0x004000, 0x005500, 0x006A00, 0x008000, 0x009500, 0x00AA00, 0x00BF00, 0x00D500, 0x00EA00, 0x00FF00, 0x15FF15, 0x2BFF2B, 0x40FF40, 0x55FF55, 0x6AFF6A];
		private var corAtual:int = 0;
		private var timerToChangeColor:Timer = new Timer(1 * 1000);
		
		public var particulas:Vector.<Particula> = new Vector.<Particula>();
		private var timer:Timer;
		
		public var counting:Boolean = false;
		public var count:int = 0;
		
		public function CamadaEletrons(larguraAltura:Number, comprimento:Number, velMin:Number, velMax:Number, particulasSegundo:int, deslocamentoX:Number) 
		{
			this.larguraAltura = larguraAltura;
			this.comprimento = comprimento;
			this.velMin = velMin;
			this.velMax = velMax;
			this.nParticulas = particulasSegundo;
			this.vetorDeslocamento = new Vector3D();
			
			vetorDeslocamento.x = larguraAltura;
			vetorDeslocamento.y = larguraAltura;
			vetorDeslocamento.z = larguraAltura;
			
			cubo = new WireframeCube(2 * comprimento, 2 * larguraAltura, 2 * larguraAltura, 0x000000);
			cubo.y = larguraAltura;
			addChild(cubo);
			
			timerToChangeColor.addEventListener(TimerEvent.TIMER, changeColor);
			timerToChangeColor.start();
			
			//var fundo:PlaneGeometry = new PlaneGeometry(61, 61);
			//var material:ColorMaterial = new ColorMaterial(0xFFFFFF);
			//material.bothSides = true;
			//var mesh:Mesh = new Mesh(fundo, material);
			//mesh.rotationZ = 90;
			//addChild(mesh);
			
			//var cubo:CylinderGeometry = new CylinderGeometry(raio, raio, 2 * comprimento, 20, 1, false, false);
			//var material:ColorMaterial = new ColorMaterial(0x0000FF, 0.1);
			//material.bothSides = true;
			//var mesh:Mesh = new Mesh(cubo, material);
			//mesh.rotationZ = 90;
			//addChild(mesh);
			//mesh.y = raio;
			
			criaEletrons();
			
			createParticulas();
			cron.start();
			//startAnimation();
			//enterFrame(null);
		}
		
		private function changeColor(e:TimerEvent):void 
		{
			corAtual++;
			if (corAtual == cores.length) corAtual = 0;
		}
		
		private var eletrons:Vector.<Vector.<Eletron>> = new Vector.<Vector.<Eletron>>();
		private function criaEletrons():void 
		{
			var iAux:int = 0;
			
			for (var i:Number = -comprimento; i <= comprimento; i+=vetorDeslocamento.x) 
			{
				var eletron1:Eletron = new Eletron();
				var eletron2:Eletron = new Eletron();
				var eletron3:Eletron = new Eletron();
				var eletron4:Eletron = new Eletron();
				var eletron5:Eletron = new Eletron();
				var eletron6:Eletron = new Eletron();
				var eletron7:Eletron = new Eletron();
				var eletron8:Eletron = new Eletron();
				var eletron9:Eletron = new Eletron();
				
				eletrons[iAux] = new Vector.<Eletron>();
				eletrons[iAux].push(eletron1);
				eletrons[iAux].push(eletron2);
				eletrons[iAux].push(eletron3);
				eletrons[iAux].push(eletron4);
				eletrons[iAux].push(eletron5);
				eletrons[iAux].push(eletron6);
				eletrons[iAux].push(eletron7);
				eletrons[iAux].push(eletron8);
				eletrons[iAux].push(eletron9);
				iAux++;
				
				eletron1.z = -vetorDeslocamento.z;
				eletron2.z = 0;
				eletron3.z = vetorDeslocamento.z;
				eletron4.z = -vetorDeslocamento.z;
				eletron5.z = 0;
				eletron6.z = vetorDeslocamento.z;
				eletron7.z = -vetorDeslocamento.z;
				eletron8.z = 0;
				eletron9.z = vetorDeslocamento.z;
				
				eletron1.y = 2 * vetorDeslocamento.y;
				eletron2.y = 2 * vetorDeslocamento.y;
				eletron3.y = 2 * vetorDeslocamento.y;
				eletron4.y = vetorDeslocamento.y;
				eletron5.y = vetorDeslocamento.y;
				eletron6.y = vetorDeslocamento.y;
				eletron7.y = 0;
				eletron8.y = 0;
				eletron9.y = 0;
				
				var posX:Number = i;
				eletron1.x = posX;
				eletron2.x = posX;
				eletron3.x = posX;
				eletron4.x = posX;
				eletron5.x = posX;
				eletron6.x = posX;
				eletron7.x = posX;
				eletron8.x = posX;
				eletron9.x = posX;
				
				addChild(eletron1);
				addChild(eletron2);
				addChild(eletron3);
				addChild(eletron4);
				addChild(eletron5);
				addChild(eletron6);
				addChild(eletron7);
				addChild(eletron8);
				addChild(eletron9);
			}
		}
		
		private function getNextVectorPos(posX:Number):int
		{
			var indice:int = Math.ceil((posX + comprimento)/vetorDeslocamento.x);
			
			return indice;
		}
		
		private function createParticulas():void 
		{
			var displacement:Number = (2 * comprimento / nParticulas);
			for (var i:int = 0; i < nParticulas; i++) 
			{
				//var cor:uint = getColor(displacement * i);
				var cor:uint = 0x800000;
				var part:Particula = new Particula(cor);
				reposicionaParticula(part, (displacement * i) - comprimento);
				//if (i <= 166) reposicionaParticula(part, 50 - comprimento);
				//else if (i <= 332) reposicionaParticula(part, 150 - comprimento);
				//else reposicionaParticula(part, 250 - comprimento);
				addChild(part);
				particulas.push(part);
			}
		}
		
		private function getColor(i:int):uint 
		{
			if (i <= 100) {
				return 0xFF0000;
			}else if (i <= 200) {
				return 0x008000;
			}else {
				return 0x0000FF;
			}
		}
		
		public function startAnimation():void 
		{
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, enterFrame);
			timer.start();
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function createNewParticula(e:TimerEvent):void 
		{
			var part:Particula = new Particula();
			reposicionaParticula(part, -comprimento);
			addChild(part);
			particulas.push(part);
		}
		
		private function getInicialXvel():Number
		{
			return -0.3 + 0.6 * Math.random();
		}
		
		private function reposicionaParticula(part:Particula, positionX:Number):void
		{
			//var direcao:Vector3D = new Vector3D((Math.random() + 0.4) * (Math.random() > 0.5 ? 1 : -1), (Math.random() + 0.4) * (Math.random() > 0.5 ? 1 : -1), (Math.random() + 0.4) * (Math.random() > 0.5 ? 1 : -1));
			var direcao:Vector3D = new Vector3D(getInicialXvel(), -1 + 2 * Math.random(), -1 + 2 * Math.random());
			//var direcao:Vector3D = new Vector3D(0, (Math.random() + 0.4) * (Math.random() > 0.5 ? 1 : -1), (Math.random() + 0.4) * (Math.random() > 0.5 ? 1 : -1));
			direcao.normalize();
			var vel:Number = Math.random() * (velMax - velMin) + velMin;
			direcao.scaleBy(vel);
			part.velocidade = direcao;
			//trace(direcao.toString());
			
			part.x = positionX;
			part.y = larguraAltura + (Math.random() * (larguraAltura) * (Math.random() < 0.5 ? 1 : -1));
			part.z = Math.random() * (larguraAltura) * (Math.random() < 0.5 ? 1 : -1);
			
			part.color = cores[corAtual];
			
			part.posAnt.x = part.x;
			part.posAnt.y = part.y;
			part.posAnt.z = part.z;
			
			part.cron = 0;
			
			if(positionX == -comprimento){
				//part.blink();
				var evt:Evt = new Evt("playSound");
				evt.particula = part;
				dispatchEvent(evt);
			}
		}
		
		private var colisionDist:Number = 5;
		private function verificaColisaoEixoX(indexAtual:int, indexProx:int, part1Position:Vector3D, part1proxPosition:Vector3D):Boolean
		{
			if (indexAtual != indexProx){
				if(indexAtual < eletrons.length && indexAtual > -1){
					lookDist: for each (var pFixed:Eletron in eletrons[indexAtual]) 
					{
						var vecFixed:Vector3D = new Vector3D(pFixed.x, pFixed.y, pFixed.z);
						if (Vector3D.distance(vecFixed, part1Position) < colisionDist) {
							//Colisão detectada
							return true;
						}
						if (Vector3D.distance(vecFixed, part1proxPosition) < colisionDist) {
							//Colisão detectada
							return true;
						}
					}
				}
			}
			return false;
		}
		
		public function setAceleracao(ax:Number, ay:Number, az:Number):void
		{
			aceleracao.x = ax;
			aceleracao.y = ay;
			aceleracao.z = az;
		}
		
		public function setLight(light:PointLight):void
		{
			for each (var item:Particula in particulas) 
			{
				item.setLight(light);
			}
			
			for each (var arr:Vector.<Eletron> in eletrons) 
			{
				for each (var item2:Eletron in arr) 
				{
					item2.setLight(light);
				}
			}
			
		}
		
		private var aceleracao:Vector3D = new Vector3D(15, 0, 0);
		public var cron:Cronometer = new Cronometer();
		public function enterFrame():void
		{
			var frameTime:Number = cron.read() / 1000 * velMult;
			cron.reset();
			for each (var item:Particula in particulas) 
			{
				//Tempo desde a ultima colisão:
				var tempoTotalParticula:Number = item.cron + frameTime;
				
				//Velocidade nos 3 eixos atualizadas antes do tempo do frame:
				var direcao_atualizada:Vector3D = new Vector3D(
					item.velocidade.x + aceleracao.x * item.cron,
					item.velocidade.y + aceleracao.y * item.cron,
					item.velocidade.z + aceleracao.z * item.cron);
					
				var novaIntensidade:Number = direcao_atualizada.length;
				//A direcao_atualizada normalizada é o novo vetor de deslocamento:
				direcao_atualizada.normalize();
				
				//Novas posições após passagem do tempo do frame:
				var newX:Number = item.posAnt.x + item.velocidade.x * tempoTotalParticula + (1 / 2 * aceleracao.x * Math.pow(tempoTotalParticula, 2));
				var newY:Number = item.posAnt.y + item.velocidade.y * tempoTotalParticula + (1 / 2 * aceleracao.y * Math.pow(tempoTotalParticula, 2));
				var newZ:Number = item.posAnt.z + item.velocidade.z * tempoTotalParticula + (1 / 2 * aceleracao.z * Math.pow(tempoTotalParticula, 2));
				
				if (newX > comprimento) {
					//Se a posição x for maior que o comprimento o elétron é recolocado no inicio do tubo
					reposicionaParticula(item, -comprimento);
					if (counting) count++;
				}else {
					//Senão verificamos por colisões:
					var indexAtual:int = getNextVectorPos(item.x);
					var indexProx:int = getNextVectorPos(newX);
				
					var colision:Boolean = false;
					var colisionX:Boolean = false;
					if (Math.abs(newY - larguraAltura) > larguraAltura) {
						if (verificaColisaoEixoX(indexAtual, indexProx, new Vector3D(item.x, item.y, item.z), new Vector3D(newX, newY, newZ))) {
							//Colisão com uma particula no eixo y:
							//direcao_atualizada.x = -2 + 3 * Math.random();
							direcao_atualizada.x = getInicialXvel();
							novaIntensidade = Math.random() * (velMax - velMin) + velMin;
							colisionX = true;
						}
						direcao_atualizada.x = getInicialXvel();
						direcao_atualizada.y *= -1 * (0.8 + Math.random() * 0.4);
						colision = true;
					}
					if (Math.abs(newZ) > larguraAltura) {
						if(!colisionX){
							if (verificaColisaoEixoX(indexAtual, indexProx, new Vector3D(item.x, item.y, item.z), new Vector3D(newX, newY, newZ))) {
								//Colisão com uma particula no eixo z:
								//direcao_atualizada.x = -2 + 3 * Math.random();
								direcao_atualizada.x = 0;
								novaIntensidade = Math.random() * (velMax - velMin) + velMin;
							}
						}
						direcao_atualizada.x = getInicialXvel();
						direcao_atualizada.z *= -1 * (0.8 + Math.random() * 0.4);
						colision = true;
					}
					if(!colision){
						if (verificaColisaoEixoX(indexAtual, indexProx, new Vector3D(item.x, item.y, item.z), new Vector3D(newX, newY, newZ))) {
							//direcao_atualizada.x = -2 + 3 * Math.random();
							direcao_atualizada.x = getInicialXvel();
							direcao_atualizada.y *= -1 * (0.8 + Math.random() * 0.4);
							direcao_atualizada.z *= -1 * (0.8 + Math.random() * 0.4);
							//direcao_atualizada.y = -1 + 2 * Math.random();
							//direcao_atualizada.z = -1 + 2 * Math.random();
							novaIntensidade = Math.random() * (velMax - velMin) + velMin;
							colision = true;
						}
					}
					
					if (colision) {
						direcao_atualizada.normalize();
						direcao_atualizada.scaleBy(novaIntensidade);
						item.velocidade = direcao_atualizada;
						item.cron = frameTime;
						item.posAnt.x = item.x;
						item.posAnt.y = item.y;
						item.posAnt.z = item.z;
						newX = item.posAnt.x + item.velocidade.x * item.cron + (1 / 2 * aceleracao.x * Math.pow(item.cron, 2));
						newY = item.posAnt.y + item.velocidade.y * item.cron + (1 / 2 * aceleracao.y * Math.pow(item.cron, 2));
						newZ = item.posAnt.z + item.velocidade.z * item.cron + (1 / 2 * aceleracao.z * Math.pow(item.cron, 2));
					}else {
						item.cron += frameTime;
					}
					
					item.x = newX;
					item.y = newY;
					item.z = newZ;
					
					//if (item.x > -0.2 && item.x < 0.2) {
						//item.blink();
						//dispatchEvent(new Event("playSound"));
					//}
					
					if (item.y > 2 * larguraAltura) item.y = 2 * larguraAltura - 2;
					else if (item.y < 0) item.y = 2;
					
					if (item.z > larguraAltura) item.z = larguraAltura - 2;
					else if (item.z < -larguraAltura) item.z = -larguraAltura + 2;
					
					if (item.x < -comprimento - 5) item.visible = false;
					else item.visible = true;
				}
			}
			
			
			
			
			
			
			/*
			
			var timePassed:Number = cron.read() / 1000 * velMult;
			//cron.stop();
			cron.reset();
			//cron.start();
			
			for each (var item:Particula in particulas) 
			{
				//var newX:Number = item.x + velMult * item.direction.x;
				//var newY:Number = item.y + velMult * item.direction.y;
				//var newZ:Number = item.z + velMult * item.direction.z;
				item.cron += timePassed;
				var itemTime:Number = item.cron;
				
				var newX:Number = item.posAnt.x + item.velocidade.x * itemTime + (1 / 2 * aceleracao.x * Math.pow(itemTime, 2));
				var newY:Number = item.posAnt.y + item.velocidade.y * itemTime + (1 / 2 * aceleracao.y * Math.pow(itemTime, 2));
				var newZ:Number = item.posAnt.z + item.velocidade.z * itemTime + (1 / 2 * aceleracao.z * Math.pow(itemTime, 2));
				
				var indexAtual:int = getNextVectorPos(item.x);
				var indexProx:int = getNextVectorPos(newX);
				
				var dir:Vector3D = item.direcao;
				var vel:Number = item.intensidade;
				//var vel:Number = Math.random() * (velMax - velMin) + velMin;
				var velocidade_atualizada:Vector3D = new Vector3D(
					item.velocidade.x + aceleracao.x * itemTime,
					item.velocidade.y + aceleracao.y * itemTime,
					item.velocidade.z + aceleracao.z * itemTime);
				
				
					
				if (indexAtual != indexProx) {
					//Passou pela barreira de atomos
					if(indexAtual < eletrons.length && indexAtual > -1){
						lookDist: for each (var item2:Eletron in eletrons[indexAtual]) 
						{
							if (Vector3D.distance(new Vector3D(item2.x, item2.y, item2.z), new Vector3D(item.x, item.y, item.z)) < 2) {
								//Colisão detectada
								dir.x *= -1 + 4 * Math.random();
								dir.normalize();
								//vel = Math.random() * (velMax - velMin) + velMin;
								velocidade_atualizada.x = Math.random() * (velMax - velMin) + velMin;
								vel = velocidade_atualizada.length;
								dir.scaleBy(vel);
								item.velocidade = dir;
								item.cron = timePassed;
								itemTime = item.cron;
								item.posAnt.x = item.x;
								item.posAnt.y = item.y;
								item.posAnt.z = item.z;
								newX = item.posAnt.x + item.velocidade.x * itemTime + (1 / 2 * aceleracao.x * Math.pow(itemTime, 2));
								newY = item.posAnt.y + item.velocidade.y * itemTime + (1 / 2 * aceleracao.y * Math.pow(itemTime, 2));
								newZ = item.posAnt.z + item.velocidade.z * itemTime + (1 / 2 * aceleracao.z * Math.pow(itemTime, 2));
								break lookDist;
							}
						}
					}
				}
				
				// Colisão com as paredes
				if (newX > comprimento) reposicionaParticula(item, -comprimento);
				else {
					var collision:Boolean = false;
					if (Math.abs(newY - larguraAltura) > larguraAltura) {
						dir.y *= -1 * (0.8 + Math.random() * 0.4);
						velocidade_atualizada.y *= -1 * (0.8 + Math.random() * 0.4);
						collision = true;
					}
					if (Math.abs(newZ) > larguraAltura) {
						dir.z *= -1 * (0.8 + Math.random() * 0.4);
						collision = true;
					}
					if (collision) {
						dir.normalize();
						dir.scaleBy(vel * (0.8 + Math.random() * 0.4));
						item.velocidade = dir;
						item.cron = timePassed;
						itemTime = item.cron;
						item.posAnt.x = item.x;
						item.posAnt.y = item.y;
						item.posAnt.z = item.z;
						newX = item.posAnt.x + item.velocidade.x * itemTime + (1 / 2 * aceleracao.x * Math.pow(itemTime, 2));
						newY = item.posAnt.y + item.velocidade.y * itemTime + (1 / 2 * aceleracao.y * Math.pow(itemTime, 2));
						newZ = item.posAnt.z + item.velocidade.z * itemTime + (1 / 2 * aceleracao.z * Math.pow(itemTime, 2));
					}
				}
				
				item.x = newX;
				item.y = newY;
				item.z = newZ;
				
				//item.posAnt.x = item.x;
				//item.x += item.vel;
				if (item.x > comprimento) reposicionaParticula(item, -comprimento);
				
				//var tempo:Number = (comprimento - item.x) / item.vel;
				//Actuate.tween(item, tempo, { x:item.x + item.vel } ).ease(Linear.easeNone).onComplete(testeEnd, item);
			}
			*/
			
		}
		
		private function testeEnd(item:Particula):void 
		{
			//if (item.x > comprimento) reposicionaParticula(item, -comprimento);
			reposicionaParticula(item, -comprimento);
			//var tempo:Number = (comprimento - item.x) / item.vel;
			//Actuate.tween(item, tempo, { x:comprimento } ).ease(Linear.easeNone).onComplete(testeEnd, item);
		}
		
	}

}