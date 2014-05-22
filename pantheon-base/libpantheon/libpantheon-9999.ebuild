# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit vala cmake-utils bzr

DESCRIPTION="A library for interacting with various Pantheon Desktop Environment components"
HOMEPAGE="https://launchpad.net/libpantheon"
EBZR_REPO_URI="lp:libpantheon"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	x11-libs/gtk+:3[introspection]"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

DOCS=( AUTHORS COPYING COPYRIGHT NEWS README )

src_prepare() {
	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}