-- Ejercicio 1)
-- a_ Cualquier cosa que se evalue como true y false, por ejemplo:
--    True
--    False
-- b_ (1,1)
--    swap (4,3)
-- c) constant
constant :: Char -> Int
constant _ = 10
-- d) alwaysTrue, y alwaysFalse:
alwaysTrue :: (Int, Char) -> Bool
alwaysTrue (_,_) = True

alwaysFalse :: (Int, Char) -> Bool
alwaysFalse (_,_) = False
-- e) mapping, mapping2
mapping :: (Int -> Int) -> Int
mapping x = 10

mapping2 :: (Int -> Int) -> Int
mapping2 f = f 10
-- f) func, func2
func :: (Bool -> Bool, Int) -> (Bool -> Bool, Int)
func (x,y) = (x,y)

func2 :: (Bool -> Bool, Int) -> (Bool -> Bool, Int)
func2 (f,g) = (f, g*10)
-- g) mapToBool y mapToBool2
mapToBool :: a -> Bool
mapToBool _ = True

mapToBool2 :: a -> Bool
mapToBool2 _ = False
-- h) identity (no hay otra función total de tipo a -> a)
identity :: a -> a
identity x = x
-- bottom
-- \c -> bottom

-- 2) Permite realizar chequeos en tiempo de compilación, previniendo bugs.

-- 3) Hecho en la resolución de la práctica 1

-- 4)
first :: (a, b) -> a
first (x,_) = x

second :: (a, b) -> b
second (_,y) = y

const :: a -> b -> a
const x _ = x

compose :: (a -> b) -> (c -> a) -> c -> b
compose f g = (\x -> f(g x))

apply :: (a -> b) -> a -> b
apply f x = f x

subst :: (a -> b -> c) -> (a -> b) -> a -> c
subst f g x = f x (g x)

pairFunc :: (a-> b, c) -> d -> a -> (a -> b, (c, d), b)
pairFunc (f1,f2) x y = (f1, (f2, x), (f1 y))

{-
5) A language is statically typed if the type of a variable is known at compile
   time. This in practice means that you as the programmer must specify what
   type each variable is. The main advantage here is that all kinds of checking
   can be done by the compiler, and therefore a lot of stupid bugs are caught at
   a very early stage.
-}

{-
6)
a_ Bien formada. Rta: 16
b_ Mal formada, falta el else
c_ Depende? := No tiene un significado especifico en haskell,
   se podria definir la funcion := y usarla.
d_ Mal formada. x no puede ser un numero y Bool al mismo tiempo
e_ Bien formada. Rta: False
f_ Mal formada, necesito separar ambos con &&
-}

-- 7)

-- 8)
data ColorPrimario = Azul
                   | Rojo
                   | Amarillo
  deriving (Eq, Show)

data ColorSecundario = Color' ColorPrimario ColorPrimario
  deriving (Eq, Show)

mezclar :: ColorPrimario -> ColorPrimario -> ColorSecundario
mezclar x y = if x == y
                 then error "No mezclar el mismo color"
                 else Color' x y

data Punto = Punto Float Float
  deriving (Eq, Show)

modulo :: Punto -> Float
modulo (Punto x y) = sqrt $ x^2 + y^2

distanciaA :: Punto -> Punto -> Float
(Punto x1 y1) `distanciaA` (Punto x2 y2) = sqrt $ (x1 - x2)^2 + (y1 - y2)^2

xcoord :: Punto -> Float
xcoord (Punto x _) = x

ycoord :: Punto -> Float
ycoord (Punto _ y) = y

suma :: Punto -> Punto -> Punto
suma (Punto x1 y1) (Punto x2 y2) = Punto (x1+x2) (y1+y2)

data Punto3D = Punto3D Float Float Float
  deriving (Eq, Show)

modulo' :: Punto3D -> Float
modulo' (Punto3D x y z) = sqrt (x^2 + y^2 + z^2)

distanciaA' :: Punto3D -> Punto3D -> Float
(Punto3D x1 y1 z1) `distanciaA'` (Punto3D x2 y2 z2) =
  sqrt $ (x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2

xcoord' :: Punto3D -> Float
xcoord' (Punto3D x _ _) = x

ycoord' :: Punto3D -> Float
ycoord' (Punto3D _ y _) = y

suma' :: Punto3D -> Punto3D -> Punto3D
suma' (Punto3D x1 y1 z1) (Punto3D x2 y2 z2) = Punto3D (x1+x2) (y1+y2) (z1+z2)

data Figura = Circulo Punto Float
            | Rectangulo Punto Punto
  deriving Show

area :: Figura -> Float
area (Circulo _ r) = pi*r^2
area (Rectangulo (Punto x1 y1) (Punto x2 y2)) = (abs $ x2-x1) * (abs $ y2-y1)

perimetro :: Figura -> Float
perimetro (Circulo _ r) = 2*pi*r
perimetro (Rectangulo (Punto x1 y1) (Punto x2 y2)) = 2*base*altura
    where base = (abs $ x2-x1)
          altura = (abs $ y2-y1)

mover :: Figura -> Punto -> Figura
mover (Circulo (Punto x y) r) (Punto a b) = Circulo (Punto (x+a) (y+b)) r
mover (Rectangulo (Punto x1 y1) (Punto x2 y2)) (Punto a b) =
        Rectangulo (Punto (x1+a) (y1+b)) (Punto (x2+a) (y2+b))

data Figura3D = Esfera Punto3D Float
              | Cubo Punto3D  Punto3D  Punto3D  Punto3D
              | Cilindro Punto3D Float Float
  deriving Show

area' :: Figura3D -> Float
area' (Esfera _ r)     = 4*pi*r^2
area' (Cilindro _ h r) = 2*pi*r*(r + h)
area' (Cubo _ _ a b)   = 6 * arista^2
  where arista = a `distanciaA'` b

volumen' :: Figura3D -> Float
volumen' (Esfera _ r)      = (4/3) * pi * r^3
volumen' (Cilindro _ h r)  = pi*(r^2)*h
volumen' (Cubo _ _ a b)    = arista^3
  where arista = a `distanciaA'` b

{-
9)
a_ error "bottom"
b_ f :: Int -> a
   f x = x + f x
c_ g :: a -> b
   g x = error "failure"
d_ h :: c -> c
   h x = error "error"

10)
Ejercicio 1.6.3 del "Introduction to Functional Programming using Haskell"
de Bird.
La función es invalida. El argumento de tom es una función (única forma
de que el retorno x x sea valido).
Supongamos que x :: A -> B; x se aplica a x, por lo que tendría que ser
A = A -> B, pero no existe tal tipo A que pueda cumplir con ello.
-}

-- 11)
smaller (x,y,z) | x <= y && x <= z = x
                | y <= x && y <= z = y
                | z <= x && z <= y = z

smaller' :: (Ord a) => (a,a,a) -> a
smaller' = \(x, y, z) -> if x <= y && x <= z
                            then x
                            else if y <= x && y <= z
                                    then y
                                    else z

-- El x a izquierda del = no es el mismo del x a la derecha. El scope es distinto.
scnd :: a -> b -> b
scnd x = \x -> x

scnd' :: a -> b -> b
scnd' = \x -> \y -> y

andThen :: Bool -> Bool -> Bool
andThen True y = y
andThen False _ = False

andThen' :: Bool -> Bool -> Bool
andThen' = \x -> \y -> if x == True
                          then y
                          else False

-- 12)
iff :: Bool -> Bool -> Bool
iff = \x -> \y -> if x
                     then not y
                     else y
iff' :: Bool -> Bool -> Bool
iff' x y = if x
              then not y
              else y

-- Notar el scope de las variables! La primera x es distinta a la 2da y 3ra,
-- que entre ellas son iguales
alpha :: a -> b -> b
alpha = \x -> \x -> x

alpha' :: a -> b -> b
alpha' _ y = y

-- 13)
bhaskara :: Floating a => (a,a,a) -> (a,a)
bhaskara (a,b,c) = ((-b + sqrtDet)/(2*a), (-b - sqrtDet)/(2*a))
  where sqrtDet = sqrt $ b^2 - (4*a*c)

{-
14)
a_ No esta bien formada: Error de tipo
b_ No, no se puede hacer && entre Num y Bool: Error de tipo
c_ Esta bien formada. Rta: 4
d_ No, no se sabe si retorna Bool o Num: Error de tipo
e_ Qué es a? Qué b? Qué hago con el ;? : Error sintáctico
-}
