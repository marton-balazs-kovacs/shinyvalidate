% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/validator.R
\name{InputValidator}
\alias{InputValidator}
\title{Shiny validation object}
\description{
An R6 class for adding realtime input validation to Shiny apps.
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{InputValidator$new()}}
\item \href{#method-add_validator}{\code{InputValidator$add_validator()}}
\item \href{#method-add_rule}{\code{InputValidator$add_rule()}}
\item \href{#method-enable}{\code{InputValidator$enable()}}
\item \href{#method-disable}{\code{InputValidator$disable()}}
\item \href{#method-is_valid}{\code{InputValidator$is_valid()}}
\item \href{#method-validate}{\code{InputValidator$validate()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
Create a new validator object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$new(priority = 1000, session = getDefaultReactiveDomain())}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{priority}}{When a validator object is enabled, it creates an
internal [shiny::observe()] to keep validation feedback in the UI
up-to-date. This parameter controls the priority of that observer. It's
highly recommended to keep this value higher than the priorities of any
observers that do actual work, so users see validation updates quickly.}

\item{\code{session}}{The Shiny `session` object. (You should probably just use
the default.)}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-add_validator"></a>}}
\if{latex}{\out{\hypertarget{method-add_validator}{}}}
\subsection{Method \code{add_validator()}}{
Add another `InputValidator` object to this one, as a
"child". Any time this validator object is asked for its validity, it
will only return `TRUE` if all of its child validators are also valid;
and when this validator object is enabled (or disabled), then all of its
child validators are enabled (or disabled) as well.

This is intended to help with validating Shiny modules. Each module can
create its own `InputValidator` object and populate it with rules, then
return that object to the caller.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$add_validator(validator)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{validator}}{A `InputValidator` object.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-add_rule"></a>}}
\if{latex}{\out{\hypertarget{method-add_rule}{}}}
\subsection{Method \code{add_rule()}}{
Add an input validation rule. Each input validation rule
  applies to a single input. You can add multiple validation rules for a
  single input, by calling `add_rules()` multiple times; the first
  validation rule for an input that fails will be used, and will prevent
  subsequent rules for that input from executing.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$add_rule(
  inputId,
  rule,
  ...,
  session. = getDefaultReactiveDomain()
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{inputId}}{A single-element character vector indicating the ID of the
input that this rule applies to. (Note that this name should _not_ be
qualified by a module namespace; e.g. pass `"x"` and not
`session$ns("x")`.)}

\item{\code{rule}}{A function that takes (at least) one argument: the input's
value. The function should return `NULL` if it passes validation, and
if not, a single-element character vector containing an error message
to display to the user near the input. You can alternatively provide a
single-sided formula instead of a function, using `.` as the variable
name for the input value being validated.}

\item{\code{...}}{Optional: Additional arguments to pass to the `rule` function
whenever it is invoked.}

\item{\code{session.}}{The session object to which the input belongs. (There's
almost never a reason to change this from the default.)}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-enable"></a>}}
\if{latex}{\out{\hypertarget{method-enable}{}}}
\subsection{Method \code{enable()}}{
Begin displaying input validation feedback in the user
  interface. Once enabled, this validator object will automatically keep
  the feedback up-to-date. (It's safe to call the `enable()` method
  on an already-enabled validator.)
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$enable()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-disable"></a>}}
\if{latex}{\out{\hypertarget{method-disable}{}}}
\subsection{Method \code{disable()}}{
Clear existing input validation feedback in the user
  interface for all inputs represented in this validator's ruleset, and
  stop providing feedback going forward. Once disabled, `enable()` can be
  called to resume input validation.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$disable()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-is_valid"></a>}}
\if{latex}{\out{\hypertarget{method-is_valid}{}}}
\subsection{Method \code{is_valid()}}{
Returns `TRUE` if all input validation rules currently pass,
  `FALSE` if not.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$is_valid(include_child_validators = TRUE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{include_child_validators}}{If `TRUE`, this method will only return
`TRUE` if all child validators also return `TRUE`. If `FALSE`, then
only the rules registered directly against this validator object will
be considered.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-validate"></a>}}
\if{latex}{\out{\hypertarget{method-validate}{}}}
\subsection{Method \code{validate()}}{
Run validation rules and gather results. For advanced usage
  only; most apps should use the `is_valid()` and `enable()` methods
  instead. The return value of this method is a named list, where the
  names are (fully namespace qualified) input IDs, and the values are
  either `NULL` (if the input value is passing) or a single-element
  character vector describing a validation problem.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$validate(include_child_validators = TRUE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{include_child_validators}}{If `TRUE`, this method will call the
`validate()` method on all child validator objects and merge the
results with this validator's results. If `FALSE`, then only the rules
directly added to this validator object will be considered.}
}
\if{html}{\out{</div>}}
}
}
}
