#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define HEPOCH_D (18)
#define HEPOCH_M (3)
#define HEPOCH_Y (622)

struct g_date {
  uint8_t	d;
  uint8_t	m;
  uint32_t	y;
};

struct h_date {
  uint8_t	d;
  uint8_t	m;
  uint32_t	y;
};

int
leap_hijri (year)
     uint32_t year;
{
  return (!(year % 4) && (!(year % 128) || year % 64));
}

int
leap_gregorian (year)
     uint32_t year;
{
  return (!(year % 4) && ((year % 100) || !(year % 400)));
}

uint8_t
day_count_hijri (d)
     struct h_date *d;
{
  switch (d->m)
    {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
      return 31;
    case 12:
      if (leap_hijri (d->y))
	return 30;
      else
	return 29;
    }

  return 30;
}

uint8_t
day_count_gregorian (d)
     struct g_date *d;
{
  switch (d->m)
    {
    case 2:
      if (leap_gregorian (d->y))
	return 29;
      else
	return 28;
    case 4:
    case 6:
    case 9:
    case 11:
      return 30;
    }

  return 31;
}

void
next_hijri_date (d)
     struct h_date *d;
{
  uint8_t md = day_count_hijri (d);

  if (d->d >= md)
    {
      d->d = 1;

      if (d->m >= 12)
	{
	  d->y += 1;
	  d->m = 1;
	}
      else
	d->m += 1;
    }
  else
    d->d += 1;
}

void
next_gregorian_date (d)
     struct g_date *d;
{
  uint8_t md = day_count_gregorian (d);

  if (d->d >= md)
    {
      d->d = 1;

      if (d->m >= 12)
	{
	  d->y += 1;
	  d->m = 1;
	}
      else
	d->m += 1;
    }
  else
    d->d += 1;
}

struct h_date
gregorian_to_hijri (g1)
     struct g_date *g1;
{
  struct h_date h;
  struct g_date g0;

  h.d = 1;
  h.m = 1;
  h.y = 1;

  g0.d = HEPOCH_D;
  g0.m = HEPOCH_M;
  g0.y = HEPOCH_Y;

  for (; g0.d != g1->d || g0.m != g1->m || g0.y != g1->y;)
    {
      next_gregorian_date (&g0);
      next_hijri_date (&h);
    }

  return h;
}

struct g_date
hijri_to_gregorian (h1)
     struct h_date *h1;
{
  struct g_date g;
  struct h_date h0;

  g.d = HEPOCH_D;
  g.m = HEPOCH_M;
  g.y = HEPOCH_Y;

  h0.d = 1;
  h0.m = 1;
  h0.y = 1;

  for (; h0.d != h1->d || h0.m != h1->m || h0.y != h1->y;)
    {
      next_hijri_date (&h0);
      next_gregorian_date (&g);
    }

  return g;
}

static const char *days[7] = {
#ifdef _POLSKI
# ifndef _SHORT_DAYS
    "Niedziela",
    "Poniedziałek",
    "Wtorek",
    "Środa",
    "Czwartek",
    "Dżumuha"
    "Sobota",
# else
    "Niedź.",
    "Pon.",
    "Wt.",
    "Śr.",
    "Czw.",
    "Dżu.",
    "Sob."
# endif /* _SHORT_DAYS */
#else
# ifndef _SHORT_DAYS
    "Primidi",
    "Duodi",
    "Tridi",
    "Tétradi",
    "Pentadi",
    "Joumouha",
    "Samedi",
# else
    "Pri",
    "Duo",
    "Tri",
    "Tét",
    "Pen",
    "Jou",
    "Sam"
# endif /* _SHORT_DAYS */
#endif /* _POLSKI */
};
  
static const char *months[12] = {
#ifdef _POLSKI
/* Wykluczenie politeistycznych nazw miesięcy */
# ifndef _SHORT_MONTHS
    "Brzeźnia",
    "Kwietnia",
    "Trawnia",
    "Czerwca",
    "Lipca",
    "Sierpnia",
    "Września",
    "Października",
    "Listopada",
    "Grudnia",
    "Stycznia",
    "Lutego"
# else
    "Brzeź.",
    "Kwiec."
    "Traw.",
    "Czerw.",
    "Lip.",
    "Sierp.",
    "Wrześ.",
    "Paźdź.",
    "List.",
    "Grudź.",
    "Stycz.",
    "Lut.",
# endif /* _SHORT_MONTHS */
#else
# ifndef _SHORT_MONTHS
    "Germinal",
    "Floréal",
    "Prairial",
    "Messidor",
    "Thermidor",
    "Fructidor",
    "Vendémiaire",
    "Brumaire",
    "Frimaire",
    "Nivôse",
    "Pluviôse",
    "Ventôse"
# else
    "Germ",
    "Flor",
    "Prai",
    "Mess",
    "Ther",
    "Fruc",
    "Vend",
    "Brum",
    "Frim",
    "Niv",
    "Pluv",
    "Vent"
# endif /* _SHORT_MONTHS */
#endif /* _POLSKI */
};

int
main (argc, argv)
     int argc;
     char *const argv[];
{
  if (argc == 1)
    {
      time_t t;
      struct tm tm;

      uint8_t wd;

      struct h_date h;
      struct g_date g;

      t = time (NULL);
      tm = *localtime (&t);

      g.y = tm.tm_year + 1900;
      g.m = tm.tm_mon + 1;
      g.d = tm.tm_mday;
      wd  = tm.tm_wday;

      h = gregorian_to_hijri (&g);

      printf ("%s %u %s %u\n", days[wd], h.d, months[h.m - 1], h.y);
    }
  else if (argc == 4)
    {
      struct h_date h;
      struct g_date g;

      h.d = (uint8_t)strtol (argv[1], NULL, 10);
      if (!h.d)
	{
	  fprintf (stderr, "Invalid day number: '%s'\n'", argv[1]);

	  return 1;
	}

      h.m = (uint8_t)strtol (argv[2], NULL, 10);
      if (!h.m)
	{
	  uint8_t i;

	  h.m = 12;

	  for (i = 0; i < 12; i++)
	    {
	      if (!strcmp (months[i], argv[2]))
		{
		  h.m = i + 1;
		  break;
		}
	    }

	  if (h.m >= 12)
	    {
	      fprintf (stderr, "Invalid month: '%s'\n", argv[2]);

	      return 1;
	    }
	}

      h.y = (uint32_t)strtol (argv[3], NULL, 10);
      if (h.y <= 0)
	{
	  fprintf (stderr, "Invalid year: '%s'\n'", argv[3]);

	  return 1;
	}

      g = hijri_to_gregorian (&h);

      printf ("%u-%u-%u\n", g.d, g.m, g.y);
    }
  else
    {
      fprintf (stderr, "Usage: %s [<day> <month> <year>]\n", argv[0]);

      return 1;
    }

  return 0;
}
