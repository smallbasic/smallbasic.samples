
' Vigenere Cipher
'
' Based on the paperback book:
'  Title:  "The Everything Cryptograms book"
'  Author: "Nikki Katz"
'  ISBN:   1-59337-319-8
'
' See also: http://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher
'

const a_index = asc(" ")
const z_index = asc("z")

'
' encode the phrase character with the given key character
'
func encode(phrase, key)
  local phrase_index = asc(phrase)
  local key_index = asc(key)
  local code = phrase_index + (key_index - a_index)

  if (code > z_index) then
    code = a_index + (code - z_index) - 1
  endif

  encode = chr(code)
end

'
' decode the cypher character with the given key character
'
func decode(cypher, key)
  local cypher_index = asc(cypher)
  local key_index = asc(key)
  local plain

  if (key_index > cypher_index) then
    plain = cypher_index + (z_index - key_index) + 1
  else
    plain = a_index + (cypher_index - key_index)
  endif
  
  decode = chr(plain)
end

'
' encrypt or decrypt the given phrase using key
'
func crypt(phrase, key, func_p)
  local result = ""
  local len_phrase = len(phrase) - 1
  local len_key = len(key)
  local k_i = 0
  local i, p, k

  for i = 0 to len_phrase
    p = mid(phrase, i + 1, 1)
    k = mid(key, k_i + 1, 1)
    
    result += call(func_p, p, k)
    
    k_i ++
    if (k_i = len_key) then
      k_i = 0
    endif
  next i 
  crypt = result
end

'
' wrapper function for crypt to encrypt the phrase
'
func encrypt(phrase, key)
  encrypt = crypt(phrase, key, @encode)
end

'
' wrapper function for crypt to decrypt the cypher
'
func decrypt(cypher, key)
  decrypt = crypt(cypher, key, @decode)
end

'
' unit test function
'
sub test
  local cypher, plain, phrase, key

  phrase = "Love all trust a few, do wrong to none"
  key = "turnip"
  cypher = encrypt(phrase, key)
  plain = decrypt(cypher, key)

  if (phrase != plain) then
    ? "Failed to decode"
  else 
    ? cypher
    ? plain
  endif
end

key = "smallbasic"
cypher = "K_G]])'K7+s[YlR^Kk]U]m u"
? decrypt(cypher, key)
