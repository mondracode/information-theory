clc;

% Se pide la entrada de la matriz al usuario
p = input("Ingrese la matriz P: ");

fprintf("\n--------------CODIFICACIÓN--------------\n")

% Se crea la identidad de tamaño k
k = size(p, 1);
n = 0;
i = eye(k);

% Y se concatena a la transpuesta de P para formar la matriz generadora
% Que luego convertimos a booleano
g = [i p'];

% El k particular del ejercicio es 3, entonces sabemos que hay 8 posibles palabras
% Vamos a codificarlas

fprintf("Palabra sin codificar \tPalabra codificada\n")
disp("----------------------------------------")

% para cada palabra
for idx = 0:(2^k)-1
  % convertimos a binario
  raw_word = dec2bin(idx, k);
  fprintf("\t%s", raw_word)

  % y a partir del binario hacemos un vector
  raw_word_array = [];
  for character = raw_word
    raw_word_array(end + 1) = str2double(character);
  end

  % a este vector se le aplica c = d * G
  % necesitamos resultados binarios, entonces aplicamos mod
  encoded_word_array = mod(raw_word_array * g, 2);
  n = size(encoded_word_array, 2);
    
  % y convertimos a string por consistencia
  fprintf("\t\t%s\n",sprintf('%d', encoded_word_array))
end

fprintf("\n-------------DECODIFICACIÓN-------------\n")
raw_word = input("Ingrese la palabra a decodificar: ", 's');
disp("----------------------------------------")

% Para decodificar, debemos calcular el síndrome
% Comenzamos con HˆT
m = n - k;
i = eye(m);

h_t = vertcat(p', i);

% y a partir del binario hacemos un vector
  raw_word_array = [];
  for character = raw_word
    raw_word_array(end + 1) = str2double(character);
  end

  % y calculamos el síndrome con r * HˆT
  % nuevamente aplicamos mod 2 para obtener valores binarios
  syndrome = mod(raw_word_array * h_t, 2);
    
  if sum(syndrome) > 0
      % si el síndrome contiene valores diferentes a 0, hay error
      % entonces miramos en dónde
      for idx = 1:size(h_t, 1)
          % comparamos el síndrome con todas las filas de HˆT
          row = h_t(idx,:);

          % si el síndrome coincide con una fila, hallamos
          % la ubicación del error
         if row == syndrome
            fprintf("La palabra %s tiene un error en el bit número %d\n",raw_word ,idx)
            return;
         end
      end
      fprintf("Esto no debería ocurrir\n")
  end

  % en caso contrario, no hay error
  decoded_word = sprintf('%d', raw_word_array(1:k));

  fprintf("La palabra %s no tiene errores\n", raw_word)
  fprintf("La palabra decodificada es %s\n", decoded_word)
  
