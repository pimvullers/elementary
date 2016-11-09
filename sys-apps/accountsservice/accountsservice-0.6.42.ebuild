# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit gnome2 systemd

DESCRIPTION="D-Bus interfaces for querying and manipulating user account information"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/AccountsService/"
SRC_URI="https://www.freedesktop.org/software/${PN}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc x86"

IUSE="doc +introspection selinux systemd +ubuntu"
SRC_URI="${SRC_URI}
	ubuntu? ( https://launchpad.net/ubuntu/+archive/primary/+files/accountsservice_0.6.42-0ubuntu1.debian.tar.xz )"

CDEPEND="
	>=dev-libs/glib-2.37.3:2
	sys-auth/polkit
	introspection? ( >=dev-libs/gobject-introspection-0.9.12:= )
	systemd? ( >=sys-apps/systemd-186:0= )
	!systemd? ( sys-auth/consolekit )
	ubuntu? ( app-crypt/gcr )
"
DEPEND="${CDEPEND}
	dev-libs/libxslt
	dev-util/gdbus-codegen
	>=dev-util/gtk-doc-am-1.15
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto )
"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-accountsd )
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.35-gentoo-system-users.patch"
	
	sed -i s/gdm3/gdm/ ${WORKDIR}/debian/patches/0007-add-lightdm-support.patch

	# Ubuntu patches
	if use ubuntu; then
		einfo "Applying patches from Ubuntu:"
		for patch in `cat "${FILESDIR}/${P}-ubuntu-patch-series"`; do
			epatch "${WORKDIR}/debian/patches/${patch}"
		done
	fi

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--disable-more-warnings \
		--localstatedir="${EPREFIX}"/var \
		--enable-admin-group="wheel" \
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)" \
		$(use_enable doc docbook-docs) \
		$(use_enable introspection) \
		$(use_enable systemd)
}
