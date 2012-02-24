%lex

%%

[^><+-.,\[\]]+						/* skip whitespace */
">"									return ">"
"<"									return "<"
"+"									return "+"
"-"									return "-"
"."									return "."
","									return ","
"["									return "["
"]"									return "]"
<<EOF>>								return 'EOF'

/lex

/* operator associations */

%start program

%%

program
	: commandlist EOF
		{{ 
			$$ = ['var tape = [0],',
				  '    pointer = 0,',
				  '    safetyCheck = function(){',
				  '        if(typeof tape[pointer] === "undefined"){',
				  '            tape[pointer] = 0;',
				  '        }',
				  '    },',
				  '    output = function(){',
				  '        console.log(String.fromCharCode(tape[pointer]));',
				  '    },',
				  '    input = function(){',
				  '        return prompt("Enter a character").charCodeAt();',
				  '    };'];
			$$ = $$.concat($1);
			
			require('console').log($$.join('\n'));
			return $$.join('\n'); 
		}}
	;
	
commandlist
	: commandlist command
		{{ 
		    $1.push($2);
		    $$ = $1; }}
	| command
		{ $$ = [$1] }
	;

command
	: '[' commandlist ']'
		{{
			$$ = ['while(tape[pointer] > 0){', 
				  $2.join('\n'),
				  '}'].join('\n');
		}}
	| '>'
		{$$ = 'pointer++;'}
	| '<'
		{$$ = 'pointer--;'}
	| '+'
		{{
			$$ = ['safetyCheck();', 'tape[pointer]++;'].join('\n');
		}}
	| '-'
		{{
			$$ = ['safetyCheck();', 'tape[pointer]--;'].join('\n');
		}}
	| '.'
		{{
			$$ = 'output();';
		}}
	| ','
		{{
			$$ = 'tape[pointer] = input();';
		}}
	;