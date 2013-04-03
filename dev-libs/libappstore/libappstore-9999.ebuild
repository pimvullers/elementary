# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit vala cmake-utils bzr

DESCRIPTION="Use PackageKit and SQLHeavy to build a fast distro agnostic applications store."
HOMEPAGE="https://launchpad.net/libappstore"
EBZR_REPO_URI="lp:libappstore"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gtk"

RDEPEND="
	app-admin/packagekit-base
	dev-db/sqlheavy:0.1
	dev-libs/glib:2
	dev-libs/libgee:0
	gtk? ( >=x11-libs/gtk+-3.3.14:3 )"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING NEWS README )
}

src_prepare() {
	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_disable gtk GTK)
		$(cmake-utils_use_want gtk GTK)
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}
