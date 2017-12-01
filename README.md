# RUC Ecuador Document Validator

A validator made in Ruby, and its algorithm follows all the steps to verify
the province code, ruc kind digit, verify digit, length and last digits.


Validates all kinds of RUC documents from Equador:
- RUC Natural
- RUC Privada
- RUC Pública


## Try yourself

- clone the repo and run on `irb`:

`require './ruc_equador.rb'` 

`doc = RucEquador.new('1104680135001')`

`doc.validate`
