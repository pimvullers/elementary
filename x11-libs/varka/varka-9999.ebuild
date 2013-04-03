# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit vala cmake-utils bzr

DESCRIPTION="A library on top of gtk to build applications"
HOMEPAGE="http://launchpad.net/varka"
EBZR_REPO_URI="lp:varka"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS COPYING NEWS README"
}

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

