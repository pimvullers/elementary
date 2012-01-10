# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils autotools-utils bzr

DESCRIPTION="Me indicator"
HOMEPAGE="https://launchpad.net/indicator-me"
EBZR_REPO_URI="lp:indicator-me"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
#	sed -i 's/indicator3/indicator3-0.4/' configure.ac

	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
#	local myeconfargs=(
#		--disable-schemas-compile
#	)

	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update --uninstall
}

