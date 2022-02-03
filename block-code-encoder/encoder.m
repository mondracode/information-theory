clc;

% Se pide la entrada de la matriz al usuario
p = input("Ingrese la matriz P: ");

% Se crea la identidad de tamaño k
k = size(p, 1);
i = eye(k);

% Y se concatena a la transpuesta de P para formar la matriz generadora
% Que luego convertimos a booleano
g = [i p']

% El k particular del ejercicio es 3, entonces sabemos que hay 8 posibles palabras
% Vamos a codificarlas

% para cada palabra
for idx = 0:(2^k)-1
  % convertimos a binario
  raw_word = dec2bin(idx, k)

  % y a partir del binario hacemos un vector
  raw_word_array = [];
  for character = raw_word
    raw_word_array(end + 1) = str2double(character);
  end

  % a este vector se le aplica c = d * G
  % necesitamos resultados binarios, entonces aplicamos mod
  encoded_word_array = mod(code_word_array * g, 2);
    
  % y convertimos a string por consistencia
  sprintf('%d', encoded_word_array)

  disp("------------------------")
end
