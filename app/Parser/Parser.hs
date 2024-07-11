{-# Language OverloadedStrings #-}

module Parser.Parser where

import Control.Applicative
import Control.Monad
import Data.Text (Text)
import Data.Void
import Text.Megaparsec hiding (State)
import Text.Megaparsec.Char
import qualified Data.Text as T
import qualified Text.Megaparsec.Char.Lexer as L

x = "SQL Parser"

data Program = Program [TableCommand] Query

data TableCommand = Create CreateCommand
                  | Insert InsertCommand

data CreateCommand = CreateCommand Name (Maybe [Name])

data InsertCommand = InsertCommand Name Insertion

data Insertion = Values [Entry]
               | InsertionQuery Query

data Query = Query [Name] [Name] (Maybe WherePart)

data WherePart = WherePart Expression

data Expression = And Expression Expression
                | Or Expression Expression
                | Not Expression
                | Parens Expression
                | Comparison Operand Operator Operand

type Name = String

data Entry = StringEntry String
           | NumberEntry Double

data Operand = OperandName Name
             | OperandEntry Entry

data Operator = LessThan
              | GreaterThan
              | Equal
