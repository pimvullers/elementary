# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit font

DESCRIPTION="Raleway is an elegant sans-serif typeface, designed in a single thin weight."
HOMEPAGE="http://www.impallari.com/projects/overview/matt-mcinerneys-raleway-family"
SRC_URI="http://www.impallari.com/media/uploads/prosources/update-100-source.zip -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

pkg_setup() {
	S="${WORKDIR}/${PN}-family-v${PV}"
	FONT_S="${S}"
	FONT_SUFFIX="ttf"

	font_pkg_setup
}
